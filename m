From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jul 2014 11:18:41 +0100
Subject: [PATCH 0/6] ARM: rockchip: add initial support for rk3288
In-Reply-To: <1471578.ILeMmG2DL6@diego>
References: <1471578.ILeMmG2DL6@diego>
Message-ID: <20140717101841.GF21153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 11:58:00PM +0100, Heiko St?bner wrote:
> This series adds the initial support for Rockchip rk3288 socs including
> debug uart and devicetree files for the rk3288 evaluation board and
> enables these boards to boot into an initramfs.
> 
> The series depends on an updated bootloader, which must start the timer
> supplying the architected timer, which we will hopefully get in the next
> days. It also depends on the patch
>     "irqchip: gic: Add binding probe for ARM GIC400"
> which will hopefully make it into the irqchip tree shortly.
> 
> 
> Heiko Stuebner (6):
>   dt-bindings: arm: add arm,cortex-a12 cpu compatible property
>   ARM: rockchip: add debug uart used by rk3288
>   ARM: Kconfig: set default gpio number for rockchip SoCs
>   ARM: rockchip: enable support for RK3288 SoCs
>   ARM: dts: rockchip: add core rk3288 dtsi
>   ARM: dts: add rk3288 evaluation board

For the series:

  Tested-by: Will Deacon <will.deacon@arm.com>

Cheers Heiko!

Will
