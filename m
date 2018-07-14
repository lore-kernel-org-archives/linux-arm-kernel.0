From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:38:58 -0700
Subject: [PATCH] ARM: dts: nomadik: Cut FSMC timings
In-Reply-To: <20180711202749.22211-1-linus.walleij@linaro.org>
References: <20180711202749.22211-1-linus.walleij@linaro.org>
Message-ID: <20180714213858.655livr4pcqzx62v@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 10:27:49PM +0200, Linus Walleij wrote:
> After the work done by Thomas Petazzoni, the NAND chip timings
> can be read out from the chip instead of open coded in the
> device tree, so let's just remove the timing information.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks, please apply this directly on some DTS
> branch, I do not plan to send any more Nomadik DTS updates
> this kernel cycle.

Applied, thanks!


-Olof
