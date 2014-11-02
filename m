From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Nov 2014 13:31:05 +0100
Subject: [PATCH v3 0/2] ARM: dts: rockchip: EMAC Rockchip for RK3066 SoCs
 and MarsBoard RK3066
In-Reply-To: <1414923601-29504-1-git-send-email-romain.perier@gmail.com>
References: <1414923601-29504-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1789689.o50HfIjl2u@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 2. November 2014, 10:19:59 schrieb Romain Perier:
> This patches serie adds EMAC Rockchip support for RK3066 SoCs and defines an
> initial devicetree source for MarsBoard RK3066.
> 
> changes since v2:
> 	- Squashed patch 1,2 and 4 together (this is the the second patch)
> 	- Add dual-licensing for rk3066a-marsboard.dts
> 	- Renamed regulator "vaux33_reg" to "vcc_rmii" as it is written in the
> 	  schematic
> 
> changes since v1:
> 	- Replaced hoayuelectronics by hoayu as suggested by the vendor-prefix doc
> in dt-bindings
> 
> Romain Perier (2):
>   ARM: dts: rockchip: Add EMAC Rockchip for RK3066 SoCs
>   ARM: dts: rockchip: Add devicetree source for MarsBoard RK3066

applied to my dts branch for 3.19, with two small changes:

- remove FSF address in license header, per checkpatch warning
[I guess the sunxi header I copied it from also contained the address]
- rename vcc_sd0: fixed-regulator to vcc_sd0: sdmmc-regulator to prevent future 
naming conflicts with more fixed regulators
