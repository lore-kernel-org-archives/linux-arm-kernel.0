From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 19 Dec 2010 23:26:20 +0100
Subject: [PATCH 34/40] ARM: u300: convert sched_clock() to use new
	infrastructure
In-Reply-To: <E1PTYot-0006jq-1t@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYot-0006jq-1t@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTinHw8MBpEZ5UECWCN+ugV2C06yNHSw+53ZgNmP+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Convert u300 to use the new sched_clock() infrastructure for extending
> 32bit counters to full 64-bit nanoseconds.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
