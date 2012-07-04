From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 4 Jul 2012 13:10:24 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120704105653.GA20021@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120704105653.GA20021@elf.ucw.cz>
Message-ID: <20120704131024.4bb558a3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Wed, 4 Jul 2012 12:56:53 +0200,
Pavel Machek <pavel@denx.de> a ?crit :

> Hmm, strange. I see picoxcell-pc3x2.dtsi using similar
> dw-apb-uart. According to 8250_dw.c, it is not completely
> 16550-compatible, and uses slightly modified driver.
> 
> So it can be driven from dts, but not as ns16850 compatible. This
> patch does so.

I guess your patch misses the .dts bits, but other than that, looks
much better without this bizarre notifier thing.

Do you plan to resend a complete v2 with all your patches nicely
rebased? It's not that easy to review such a set of small cleanup
increments :-)

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
