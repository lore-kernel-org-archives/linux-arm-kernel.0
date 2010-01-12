From: judith.baumgarten@tu-cottbus.de (Judith Baumgarten)
Date: Tue, 12 Jan 2010 18:30:00 +0100
Subject: pxa320: change uart configuration
Message-ID: <20100112183000.14575jy4enpsv6ag@webmail.tu-cottbus.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I want to change the uart configuration of the pxa serial ports in  
order to be able to connect to different devices. The problem is, that  
it jumps back to its initial configuration, when it receives some  
data. I used stty of busybox 1.14.3 as well as the termios-structure  
to change the configuration, but it always remained the same. I could  
protect some configurations by using the TIOCSLCKTRMIOS ioctl, but the  
baudrate still jumps back.

Any ideas?

Regards
Judith

P.S.: I'm using the 2.6.28.7 kernel.

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
