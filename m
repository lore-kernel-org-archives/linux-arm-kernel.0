From: B56799@freescale.com (Meng Yi)
Date: Wed, 2 Dec 2015 14:29:36 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMl0gQVJNOiBkdHM6IGxzMTAyMWE6IEFkZCBEQ1Ug?=
 =?gb2312?Q?dts_node.?=
In-Reply-To: <20151202124003.GS692@tiger>
References: <1448433967-6710-1-git-send-email-b56799@freescale.com>,
 <20151202124003.GS692@tiger>
Message-ID: <DM2PR0301MB0912F64ECB3624D1751FADD68F0E0@DM2PR0301MB0912.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks A lot!

Regards,

Yi Meng

________________________________________
???: Shawn Guo <shawnguo@kernel.org>
????: 2015?12?2? 20:40
???: Yi Meng-B56799
??: Jianwei Wang; devicetree at vger.kernel.org; Xiubo Li; Wang Huan-B18965; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
??: Re: [PATCH 1/2] ARM: dts: ls1021a: Add DCU dts node.

On Wed, Nov 25, 2015 at 02:46:06PM +0800, Meng Yi wrote:
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>

Forgot to mention that you missed adding your own SoB.  Added when
applying.

Shawn

> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 9430a99..f01c98b 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -428,6 +428,16 @@
>                                <&platform_clk 1>;
>               };
>
> +             dcu: dcu at 2ce0000 {
> +                     compatible = "fsl,ls1021a-dcu";
> +                     reg = <0x0 0x2ce0000 0x0 0x10000>;
> +                     interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> +                     clocks = <&platform_clk 0>;
> +                     clock-names = "dcu";
> +                     big-endian;
> +                     status = "disabled";
> +             };
> +
>               mdio0: mdio at 2d24000 {
>                       compatible = "gianfar";
>                       device_type = "mdio";
> --
> 2.1.0.27.g96db324
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
