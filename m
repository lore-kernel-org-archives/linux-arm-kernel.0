From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 04 Dec 2017 11:46:30 +0100
Subject: [PATCH] arm: dts: rockchip: fix errors in IOMMU interrupts
 property cells
In-Reply-To: <20171109223535.17368-1-robh@kernel.org>
References: <20171109223535.17368-1-robh@kernel.org>
Message-ID: <1650017.SLWRlyvIpe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 9. November 2017, 16:35:35 CET schrieb Rob Herring:
> The interrupts property in the IOMMU node for Rockchip dts file has a
> spurious extra cell causing a dtc warning:
> 
> Warning (interrupts_property): interrupts size is (16), expected multiple of 12 in /iommu at ff900800
> 
> Remove the extra cell.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi            | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-

Arnd fixed the rk3368 variant in a patch already, so I've dropped that
and applied the rk3288 fix as fix for 4.15.


Thanks
Heiko
