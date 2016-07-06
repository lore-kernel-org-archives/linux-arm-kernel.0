From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 6 Jul 2016 19:58:56 +0200
Subject: [PATCH 0/3] arm: dts: berlin: enable all dw_wdt nodes
 unconditionally
In-Reply-To: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
References: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
Message-ID: <577D46E0.7040404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.07.2016 08:41, Jisheng Zhang wrote:
> When we add watchdog dt nodes into berlin dtsi, the dw_wdt driver can't
> support multiple variants, so we have to keep one enabled and others
> disabled. After commit f29a72c24ad4 ("watchdog: dw_wdt: Convert to use
> watchdog infrastructure"), the dw_wdt driver can support multiple
> variants, so we can unconditionally enable all dw_wdt nodes now.
> 
> Jisheng Zhang (3):
>   arm: dts: berlin2: enable all wdt nodes unconditionally
>   arm: dts: berlin2q: enable all wdt nodes unconditionally
>   arm64: dts: berlin4ct: enable all wdt nodes unconditionally

Applied all three to berlin/dt and berlin64/dt respectively.

Thanks!

Sebastian

>  arch/arm/boot/dts/berlin2.dtsi             | 2 --
>  arch/arm/boot/dts/berlin2q.dtsi            | 2 --
>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 --
>  3 files changed, 6 deletions(-)
> 
