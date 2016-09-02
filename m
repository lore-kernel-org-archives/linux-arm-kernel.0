From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 16:19:20 +0200
Subject: [PATCH] ARM: defconfig: update the Integrator defconfig
In-Reply-To: <1470819132-27804-1-git-send-email-linus.walleij@linaro.org>
References: <1470819132-27804-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <6659184.HzWbtDEtGY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 10:52:12 AM CEST Linus Walleij wrote:
> The Integrators defconfig have changed due to changes in
> Kconfig for the CPU types, they use the physmap OF NOR
> driver and syscon for LEDs.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly to wherever
> defconfig updates go.

Applied to next/defconfig, thanks!

	Arnd
