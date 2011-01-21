From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 21 Jan 2011 15:23:17 +0100
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
	<43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
	<4D38641E.2000301@gmail.com>
	<c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
Message-ID: <AANLkTi=ymmg6siqwxFJyh33VwAy7ZaURcTmUZyOWEz2r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/21 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> How about below approach?
>
> -----------------------------------------------------
> [PATCH] ARM: smp: Skip secondary cpu calibration to speed-up boot

Hey this looks like a good way to do it,
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
