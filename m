From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Jun 2017 11:19:30 +0200
Subject: [PATCH v2 0/2] arm/arm64: dts: fix typo in mmc pinctrl
In-Reply-To: <20170627195831.56449-1-klaus.goger@theobroma-systems.com>
References: <20170627195831.56449-1-klaus.goger@theobroma-systems.com>
Message-ID: <2086760.HXNp32Jd3t@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 27. Juni 2017, 21:58:29 CEST schrieb Klaus Goger:
> 
> replaces all occurrences of sdmmc with sdmmc in the arm64 and arm
> rockchip devicetree files
> 
> Changes in v2:
> - split arm and arm64 changes into separate changes
> 
> Klaus Goger (2):
>   arm: dts: rockchip: fix typo in rk3036 mmc pinctrl
ARM: dts: rockchip: in future please
[arm32 uses capital letters]

>   arm64: dts: rockchip: fix typo in mmc pinctrl

applied both for 4.14 with the subject of patch1 fixed up.

Thanks
Heiko
