From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 31 Mar 2017 12:43:13 +0200
Subject: [PATCH] multi_v7_defconfig: make Rockchip DRM drivers built-in
In-Reply-To: <20170331103314.1067264-1-arnd@arndb.de>
References: <20170331103314.1067264-1-arnd@arndb.de>
Message-ID: <1995616.yTRRrZzmVW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 31. M?rz 2017, 12:33:14 CEST schrieb Arnd Bergmann:
> These cause warnings in linux-next, as the symbols have become 'bool' there:
> 
> arch/arm/configs/multi_v7_defconfig:600:warning: symbol value 'm' invalid for ROCKCHIP_INNO_HDMI
> arch/arm/configs/multi_v7_defconfig:599:warning: symbol value 'm' invalid for ROCKCHIP_DW_MIPI_DSI
> arch/arm/configs/multi_v7_defconfig:598:warning: symbol value 'm' invalid for ROCKCHIP_DW_HDMI
> arch/arm/configs/multi_v7_defconfig:597:warning: symbol value 'm' invalid for ROCKCHIP_ANALOGIX_DP
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

looks good, so for what it's worth:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko
