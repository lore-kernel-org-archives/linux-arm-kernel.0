From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Jan 2017 19:10:49 -0800
Subject: [PATCH 0/3] MPU-3050 defconfig updates
In-Reply-To: <20161227120530.31190-1-linus.walleij@linaro.org>
References: <20161227120530.31190-1-linus.walleij@linaro.org>
Message-ID: <20170110031049.GC22261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 01:05:27PM +0100, Linus Walleij wrote:
> Here are three defconfig patches to the ARM SoC tree that replace
> the use of the partial input driver for MPU-3050 with the fully featured
> IIO replacement driver.
> 
> Please apply these directly for defconfig updates post-v4.10-rc1.
> 
> Linus Walleij (3):
>   ARM: defconfig: replace MPU3050 driver on multi_v7
>   ARM: defconfig: tegra: switch to MPU3050 IIO driver
>   ARM: defconfig: pxa: cut MPU3050 input driver

Applied to next/defconfig. Thanks!


-Olof
