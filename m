From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Aug 2010 16:38:48 +0100
Subject: RS485: ioctls defined twice ?
In-Reply-To: <4C67F815.8020808@evidence.eu.com>
References: <4C67F815.8020808@evidence.eu.com>
Message-ID: <20100815153848.GA19113@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 15, 2010 at 04:22:13PM +0200, Claudio Scordino wrote:
> Hi all,
> 
> 	is there any reason why ioctls TIOCGRS485 and TIOCSRS485 are defined

Please wrap your message sensibly so I can see it while replying to you.

> The same happens also for avr32, powerpc and cris (which, however, defines
> 
> Is it duplicated code ?
> 
> Or should these values stay in both asm/ioctls.h and asm-generic/ioctls.h ?

As an exercise to help you answer your own question, please research
how asm-generic/ioctls.h get included on an avr32, powerpc, cris or
ARM kernel build.
