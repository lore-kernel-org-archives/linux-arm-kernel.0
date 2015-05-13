From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 13:39:07 +0200
Subject: [PATCH 1/2] ARM: ux500: add PERF_EVENTS to defconfig
In-Reply-To: <1431512962-24943-1-git-send-email-linus.walleij@linaro.org>
References: <1431512962-24943-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4978228.Pk7uizqdOC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 12:29:22 Linus Walleij wrote:
> The Ux500 has a perfectly working PMU so let's put the perf
> events into the defconfig. This will activate HW_PERF_EVENTS
> by default.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC people: please apply this directly to the ARM SoC
> tree in an appropriate place.
> 

Applied both patches to next/defconfig, thanks!

	Arnd
