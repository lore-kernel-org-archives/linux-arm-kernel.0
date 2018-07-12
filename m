From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 12 Jul 2018 11:31:06 +0200
Subject: [PATCH v4 0/2] arm64: rockchip: support RK3399 Ficus board
In-Reply-To: <20180706150818.5631-1-ezequiel@collabora.com>
References: <20180706150818.5631-1-ezequiel@collabora.com>
Message-ID: <31262174.ngUfOPmpOk@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 6. Juli 2018, 17:08:16 CEST schrieb Ezequiel Garcia:
> Fourth round for the RK3399 Ficus support.
> 
> Changes from v3:
>  * Fixed a regulator node name, as noted by Rob.
>  * Fixed wrong alphabetical order in vendors prefix patch, also noted by
> Rob.
> 
> Changes from v2:
>  * Dropped rk3399.dtsi changes and rebased on top of Randy's patch.
>  * Removed double empty line.
>  * Coalesced schematics comment
> 
> Changes from v1:
>  * Dropoed USB support as it's not working.
>  * Added schematics.
>  * Splitted rk3399.dtsi from new ficus.dts file.
>  * Added new vendor.
>  * Cleaned regulators syntax and stlye.
> 
> Series based on: 600b359d2b98 ("arm64: dts: rockchip: add some common
> pin-settings to rk3399").
> 
> Ezequiel Garcia (2):
>   dt-bindings: Add vendor prefix for Vamrs Ltd.
>   arm64: dts: rockchip: add 96boards RK3399 Ficus board

applied both for 4.19

Thanks
Heiko
