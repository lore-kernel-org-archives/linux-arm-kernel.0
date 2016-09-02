From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 18:20:00 +0200
Subject: [PATCH v2 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <CAK7LNARVw+mDhHT2+WjDtHpBvsxauUQpRCJeNLrQxrj0Oo=hrQ@mail.gmail.com>
References: <1470045256-9032-1-git-send-email-marc.zyngier@arm.com>
 <1470045256-9032-3-git-send-email-marc.zyngier@arm.com>
 <CAK7LNARVw+mDhHT2+WjDtHpBvsxauUQpRCJeNLrQxrj0Oo=hrQ@mail.gmail.com>
Message-ID: <19742803.nMPmp3hcfz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 1, 2016 7:00:50 PM CEST Masahiro Yamada wrote:
> > Acked-by: Duc Dang <dhdang@apm.com>
> > Acked-by: Carlo Caione <carlo@endlessm.com>
> > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 8 ++++----
> >  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 8 ++++----
> >  arch/arm64/boot/dts/apm/apm-storm.dtsi               | 8 ++++----
> >  arch/arm64/boot/dts/broadcom/ns2.dtsi                | 8 ++++----
> >  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 8 ++++----
> >  arch/arm64/boot/dts/exynos/exynos7.dtsi              | 8 ++++----
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 8 ++++----
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 8 ++++----
> >  arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 8 ++++----
> >  arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----
> 
> 
> For uniphier-ph1-ld20.dtsi,
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 

Applied to the fixes branch for 4.8, thanks

	Arnd
