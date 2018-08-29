From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Aug 2018 11:51:07 -0700
Subject: [PATCH] ARM: defconfig: Update the ARM Versatile defconfig
In-Reply-To: <20180827132708.31446-1-linus.walleij@linaro.org>
References: <20180827132708.31446-1-linus.walleij@linaro.org>
Message-ID: <20180829185107.hoxehv2yg7umirll@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 03:27:08PM +0200, Linus Walleij wrote:
> This updates the ARM Versatile defconfig to the latest
> Kconfig structural changes and adds the DUMB VGA bridge
> driver so that VGA works out of the box, e.g. with QEMU.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks:
> Please apply this directly wherever post-mergewindow
> defconfig changes should go.

Picking up for fixes since it helps testing. Applied, thanks.


-Olof
