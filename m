From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Oct 2010 10:25:34 +0200
Subject: 2.6.36-rc7-next-20101007 failed to compile
	(arch/arm/kernel/setup.c)
In-Reply-To: <4CAE1611.1020105@gai.ru>
References: <4CAE1611.1020105@gai.ru>
Message-ID: <20101008082534.GZ29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 07, 2010 at 10:48:49PM +0400, Alex Sverdlin wrote:
> make output:
> ...
>   CC      arch/arm/kernel/ptrace.o
>   CC      arch/arm/kernel/return_address.o
>   CC      arch/arm/kernel/setup.o
> /tmp/cccRqJQQ.s: Assembler messages:
> /tmp/cccRqJQQ.s:571: Error: bad instruction `isb'
> make[2]: *** [arch/arm/kernel/setup.o] Error 1
> make[1]: *** [arch/arm/kernel] Error 2
> ...
> 
> 2.6.36-rc6 compiled without this problem...
> 
> Compiler is GCC 3.4.3, complete toolchain taken from
> http://arm.cirrus.com/files/tools/arm-linux-gcc-3.4.3-1.0.1.tar.bz2

http://news.gmane.org/find-root.php?message_id=<1286308412-8252-1-git-send-email-linus.walleij@stericsson.com>
didn't make it yet into next

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
