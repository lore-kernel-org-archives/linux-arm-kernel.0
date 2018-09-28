From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Sep 2018 16:06:31 +0200
Subject: [PATCH v3 0/4] rk3328 and rock64 display support
In-Reply-To: <20180910092843.1700-1-heiko@sntech.de>
References: <20180910092843.1700-1-heiko@sntech.de>
Message-ID: <4674830.T5MsTfmpAf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 10. September 2018, 11:28:39 CEST schrieb Heiko Stuebner:
> Companion series for the display modifications adding the necessary
> devicetree stuff for display support on the rk3328-rock64.
> 
> changes in v3:
> - drop reg from hdmi port - unneeded with a single vop
>   as suggested by Robin
> 
> changes in v2:
> - add defconfig addition for the phy driver
> - adapt to changed reference clock names
> - remove trailing 0 from vop irq
> 
> Heiko Stuebner (4):
>   arm64: dts: rockchip: add Innosilicon hdmi phy node to rk3328
>   arm64: dts: rockchip: add rk3328 display nodes
>   arm64: dts: rockchip: enable display nodes on rk3328-rock64
>   arm64: defconfig: enable Rockchip Innosilicon hdmiphy

with phy and hdmi support being scheduled for 4.20,
applied these as well.
