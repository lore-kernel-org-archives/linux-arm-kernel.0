From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 17:36:06 +0000
Subject: pxa320: change uart configuration
In-Reply-To: <20100112183000.14575jy4enpsv6ag@webmail.tu-cottbus.de>
References: <20100112183000.14575jy4enpsv6ag@webmail.tu-cottbus.de>
Message-ID: <20100112173606.GF5633@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 06:30:00PM +0100, Judith Baumgarten wrote:
> I want to change the uart configuration of the pxa serial ports in order 
> to be able to connect to different devices. The problem is, that it jumps 
> back to its initial configuration, when it receives some data. I used 
> stty of busybox 1.14.3 as well as the termios-structure to change the 
> configuration, but it always remained the same. I could protect some 
> configurations by using the TIOCSLCKTRMIOS ioctl, but the baudrate still 
> jumps back.

Something will be changing it back.  A getty maybe?
