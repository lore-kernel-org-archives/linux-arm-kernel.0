From: ccross@android.com (Colin Cross)
Date: Sat, 14 May 2011 20:53:37 -0700
Subject: [PATCH 07/13] clocksource: convert ARM 32-bit up counting
	clocksources
In-Reply-To: <E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
Message-ID: <BANLkTimxm74xUp3VQTLTrwSATHB7dp9ung@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 12:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Convert ixp4xx, lpc32xx, mxc, netx, pxa, sa1100, tcc8k, tegra and u300
> to use the generic mmio clocksource recently introduced.
>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: "Hans J. Koch" <hjk@hansjkoch.de>
> Cc: Colin Cross <ccross@android.com>
> Cc: Erik Gilling <konkers@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Colin Cross <ccross@android.com>

Boot tested this patch and patch 6 on Tegra.
