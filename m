From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 19 Dec 2010 23:25:38 +0100
Subject: [PATCH 36/40] ARM: nomadik: convert sched_clock() to use new
	infrastructure
In-Reply-To: <E1PTYpX-0006jy-Tc@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYpX-0006jy-Tc@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTin=TcDAqFskD70PP11=vcOhMU8jjZWvgzjVEt2x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Convert nomadik platforms to use the new sched_clock() infrastructure
> for extending 32bit counters to full 64-bit nanoseconds.

Much better this way, thanks Russell.
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
