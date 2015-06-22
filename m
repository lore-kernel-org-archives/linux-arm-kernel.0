From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 22 Jun 2015 16:38:10 +0200
Subject: [PATCH] ARM: dts: rockchip: fix rk3288 watchdog irq
In-Reply-To: <1961157.dsytR1KvKa@phil>
References: <1961157.dsytR1KvKa@phil>
Message-ID: <4785881.zacpjkQbnc@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 19. Juni 2015, 16:31:14 schrieb Heiko Stuebner:
> The watchdog irq is actually SPI 79, which translates to the original
> 111 in the manual where the SPI irqs start at 32.
> The current dw_wdt driver does not use the irq at all, so this issue
> never surfaced. Nevertheless fix this for a time we want to use the irq.
> 
> Fixes: 2ab557b72d46 ("ARM: dts: rockchip: add core rk3288 dtsi")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied to dts changes for 4.3
