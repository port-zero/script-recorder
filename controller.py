import pty, os, subprocess
import termios, tty
import re
import time

def send_command(fd, cmd, echo=True, log_file=None, delimiter='COMMAND'):
    if cmd.strip() != '':
        if echo:
            print('>>> %s' % cmd)
        if log_file:
            print('%(delimiter)s>>>%(cmd)s<<<%(delimiter)s' % {'cmd':cmd, 'delimiter':delimiter},
                    file=log_file);
    os.write(fd, bytes(cmd+'\n', 'ascii'))

def read_to_prompt(fd):
    # FIXME: prompt chunk might include useful data
    out = b''
    while 1:
        chunk = os.read(master,1024)
        if re.match(PS1+'$', str(chunk, 'ascii')):
            return out
        if re.match(PS2+'$', str(chunk, 'ascii')):
            return None
        out += chunk


PS1='P0_SHELL_CONTROLLER_INPUT>>>'
PS2='P0_SHELL_CONTROLLER_CONT>>>'

master, slave = pty.openpty()
p = subprocess.Popen(['/bin/bash'], stdout=slave, stderr=slave, stdin=slave,
        close_fds=True, bufsize=-1)
tty.setcbreak(master) # disable tty echo
send_command(master, "export PS1='%s' PS2='%s' PROMPT_COMMAND= TERM=xterm" % (PS1,PS2), echo=False)
read_to_prompt(master) # flush to begin in a controlled environment

delimiter = 'COMMAND'
with open('outfile.ansi', 'w') as outfile:
    for line in open('testscript2.sh'):
        send_command(master, line.rstrip('\r\n'), log_file=outfile, delimiter=delimiter)
        response = read_to_prompt(master)
        if response is None: # shell expects continuation
            delimiter = 'COMMAND_CONTINUATION'
            continue
        delimiter = 'COMMAND'
        response = str(response,'ascii').rstrip('\r\n')
        if response.strip() != '':
            print(response)
            print('RESPONSE>>>%s<<<RESPONSE' % response, file=outfile)

send_command(master, "exit");
p.wait()
print('returned:', p.returncode)
#pty.spawn(['/bin/sh',], read)

