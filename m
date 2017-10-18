From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Oct 2017 11:01:34 +0800
Subject: [PATCH] ARM: dts: imx25-eukrea-mbimxsd25-baseboard: Fix the
 'cd-gpios' property
In-Reply-To: <1508193643-30243-1-git-send-email-festevam@gmail.com>
References: <1508193643-30243-1-git-send-email-festevam@gmail.com>
Message-ID: <20171018030132.GK18810@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 08:40:43PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The GPIO polarity is missing in the cd-gpios property.
> 
> Fix it, so that the following build warnings are gone:
> 
>   DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
> arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
>   DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
> arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
>   DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
> arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
>   DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
> arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
> 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
