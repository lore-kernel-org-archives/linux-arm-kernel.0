From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:22:56 +0200
Subject: [PATCH] ARM: ux500: add SCU and WD to device tree
In-Reply-To: <1431595354-2101-1-git-send-email-linus.walleij@linaro.org>
References: <1431595354-2101-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <14007518.4fLGbUSe3l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 11:22:34 Linus Walleij wrote:
> The Ux500 like other Cortex-A9 SoC's has a Snoop Control
> Unit (SCU) and a Watchdog in the same address range as
> the local timers. Add these to the SoC device tree.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: if it looks OK, please apply this directly to
> the DT branch with other ux500 DT changes, this is needed
> for cleanups when we want to remap the SCU from the DT.

Applied to next/dt, thanks!

	Arnd
