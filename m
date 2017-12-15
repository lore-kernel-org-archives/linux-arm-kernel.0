From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 10:51:05 -0200
Subject: [PATCH 05/25] arm: imx: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124631.30132-1-malat@debian.org>
References: <20171215124631.30132-1-malat@debian.org>
Message-ID: <CAOMZO5BrxG6RZWa0_LOUyjN2VyhiyKGiRXCPiOBNHQ-Fb4kCgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Fri, Dec 15, 2017 at 10:46 AM, Mathieu Malaterre <malat@debian.org> wrote:
                 reg = <0x6C>;
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 4d308d17f040..369d5a166b3e 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -129,7 +129,7 @@
>                 status = "disabled";
>         };
>
> -       pcie: pcie at 0x33800000 {
> +       pcie: pcie at 33800000 {

I have already sent a fix for this one.


>                 compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
>                 reg = <0x33800000 0x4000>,
>                       <0x4ff00000 0x80000>;
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 82ad26e766eb..a00ba897e58d 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -583,7 +583,7 @@
>                                         #address-cells = <1>;
>                                         #size-cells = <0>;
>
> -                                       pgc_pcie_phy: pgc-power-domain at IMX7_POWER_DOMAIN_PCIE_PHY {
> +                                       pgc_pcie_phy: pgc-power-domain at imx7_power_domain_pcie_phy {


Original code was correct.
