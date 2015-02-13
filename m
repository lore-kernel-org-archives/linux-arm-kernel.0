From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 13 Feb 2015 20:26:54 +0100
Subject: [PATCH 09/11] ARM: rockchip: make rockchip_suspend_init
 conditional
In-Reply-To: <1423770163-583064-10-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-10-git-send-email-arnd@arndb.de>
Message-ID: <1461239.Nh9EM2K6Yy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Februar 2015, 20:42:41 schrieb Arnd Bergmann:
> If CONFIG_PM_SLEEP is disabled, we get a build error for rockchips:
> 
> arch/arm/mach-rockchip/built-in.o: In function `rockchip_dt_init':
> :(.init.text+0x1c): undefined reference to `rockchip_suspend_init'
> 
> This adds an inline alternative for that case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org

thanks for the catch,
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I guess you will apply the whole 11-patch series en block to arm-soc, right?


Heiko
