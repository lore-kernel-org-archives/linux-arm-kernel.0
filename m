From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Sep 2015 15:39:11 +0200
Subject: [PATCH] ARM: dts: mt8135-evbp1: remove regulator-compatible usage
In-Reply-To: <1443188795-14435-1-git-send-email-javier@osg.samsung.com>
References: <1443188795-14435-1-git-send-email-javier@osg.samsung.com>
Message-ID: <5607F17F.8000805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/09/15 15:46, Javier Martinez Canillas wrote:
> The regulator-compatible property from the regulator DT binding was
> deprecated and the correct approach is to use the node's name.
>
> This patch has no functional changes since the values of the node's
> name and the regulator-compatible match for all the regulators.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thanks.

>
> ---
>
>   arch/arm/boot/dts/mt8135-evbp1.dts | 23 -----------------------
>   1 file changed, 23 deletions(-)
>
> diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
> index 357a91fc2d1d..460db6d05952 100644
> --- a/arch/arm/boot/dts/mt8135-evbp1.dts
> +++ b/arch/arm/boot/dts/mt8135-evbp1.dts
> @@ -32,7 +32,6 @@
>   			compatible = "mediatek,mt6397-regulator";
>
>   			mt6397_vpca15_reg: buck_vpca15 {
> -				regulator-compatible = "buck_vpca15";
>   				regulator-name = "vpca15";
>   				regulator-min-microvolt = < 850000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -41,7 +40,6 @@
>   			};
>
>   			mt6397_vpca7_reg: buck_vpca7 {
> -				regulator-compatible = "buck_vpca7";
>   				regulator-name = "vpca7";
>   				regulator-min-microvolt = < 850000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -50,7 +48,6 @@
>   			};
>
>   			mt6397_vsramca15_reg: buck_vsramca15 {
> -				regulator-compatible = "buck_vsramca15";
>   				regulator-name = "vsramca15";
>   				regulator-min-microvolt = < 850000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -59,7 +56,6 @@
>   			};
>
>   			mt6397_vsramca7_reg: buck_vsramca7 {
> -				regulator-compatible = "buck_vsramca7";
>   				regulator-name = "vsramca7";
>   				regulator-min-microvolt = < 850000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -68,7 +64,6 @@
>   			};
>
>   			mt6397_vcore_reg: buck_vcore {
> -				regulator-compatible = "buck_vcore";
>   				regulator-name = "vcore";
>   				regulator-min-microvolt = < 850000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -77,7 +72,6 @@
>   			};
>
>   			mt6397_vgpu_reg: buck_vgpu {
> -				regulator-compatible = "buck_vgpu";
>   				regulator-name = "vgpu";
>   				regulator-min-microvolt = < 700000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -86,7 +80,6 @@
>   			};
>
>   			mt6397_vdrm_reg: buck_vdrm {
> -				regulator-compatible = "buck_vdrm";
>   				regulator-name = "vdrm";
>   				regulator-min-microvolt = <1200000>;
>   				regulator-max-microvolt = <1400000>;
> @@ -95,7 +88,6 @@
>   			};
>
>   			mt6397_vio18_reg: buck_vio18 {
> -				regulator-compatible = "buck_vio18";
>   				regulator-name = "vio18";
>   				regulator-min-microvolt = <1620000>;
>   				regulator-max-microvolt = <1980000>;
> @@ -104,19 +96,16 @@
>   			};
>
>   			mt6397_vtcxo_reg: ldo_vtcxo {
> -				regulator-compatible = "ldo_vtcxo";
>   				regulator-name = "vtcxo";
>   				regulator-always-on;
>   			};
>
>   			mt6397_va28_reg: ldo_va28 {
> -				regulator-compatible = "ldo_va28";
>   				regulator-name = "va28";
>   				regulator-always-on;
>   			};
>
>   			mt6397_vcama_reg: ldo_vcama {
> -				regulator-compatible = "ldo_vcama";
>   				regulator-name = "vcama";
>   				regulator-min-microvolt = <1500000>;
>   				regulator-max-microvolt = <2800000>;
> @@ -124,18 +113,15 @@
>   			};
>
>   			mt6397_vio28_reg: ldo_vio28 {
> -				regulator-compatible = "ldo_vio28";
>   				regulator-name = "vio28";
>   				regulator-always-on;
>   			};
>
>   			mt6397_vusb_reg: ldo_vusb {
> -				regulator-compatible = "ldo_vusb";
>   				regulator-name = "vusb";
>   			};
>
>   			mt6397_vmc_reg: ldo_vmc {
> -				regulator-compatible = "ldo_vmc";
>   				regulator-name = "vmc";
>   				regulator-min-microvolt = <1800000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -143,7 +129,6 @@
>   			};
>
>   			mt6397_vmch_reg: ldo_vmch {
> -				regulator-compatible = "ldo_vmch";
>   				regulator-name = "vmch";
>   				regulator-min-microvolt = <3000000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -151,7 +136,6 @@
>   			};
>
>   			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
> -				regulator-compatible = "ldo_vemc3v3";
>   				regulator-name = "vemc_3v3";
>   				regulator-min-microvolt = <3000000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -159,7 +143,6 @@
>   			};
>
>   			mt6397_vgp1_reg: ldo_vgp1 {
> -				regulator-compatible = "ldo_vgp1";
>   				regulator-name = "vcamd";
>   				regulator-min-microvolt = <1220000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -167,7 +150,6 @@
>   			};
>
>   			mt6397_vgp2_reg: ldo_vgp2 {
> -				regulator-compatible = "ldo_vgp2";
>   				regulator-name = "vcamio";
>   				regulator-min-microvolt = <1000000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -175,7 +157,6 @@
>   			};
>
>   			mt6397_vgp3_reg: ldo_vgp3 {
> -				regulator-compatible = "ldo_vgp3";
>   				regulator-name = "vcamaf";
>   				regulator-min-microvolt = <1200000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -183,7 +164,6 @@
>   			};
>
>   			mt6397_vgp4_reg: ldo_vgp4 {
> -				regulator-compatible = "ldo_vgp4";
>   				regulator-name = "vgp4";
>   				regulator-min-microvolt = <1200000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -191,7 +171,6 @@
>   			};
>
>   			mt6397_vgp5_reg: ldo_vgp5 {
> -				regulator-compatible = "ldo_vgp5";
>   				regulator-name = "vgp5";
>   				regulator-min-microvolt = <1200000>;
>   				regulator-max-microvolt = <3000000>;
> @@ -199,7 +178,6 @@
>   			};
>
>   			mt6397_vgp6_reg: ldo_vgp6 {
> -				regulator-compatible = "ldo_vgp6";
>   				regulator-name = "vgp6";
>   				regulator-min-microvolt = <1200000>;
>   				regulator-max-microvolt = <3300000>;
> @@ -207,7 +185,6 @@
>   			};
>
>   			mt6397_vibr_reg: ldo_vibr {
> -				regulator-compatible = "ldo_vibr";
>   				regulator-name = "vibr";
>   				regulator-min-microvolt = <1300000>;
>   				regulator-max-microvolt = <3300000>;
>
