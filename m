From: tbergstrom@nvidia.com (=?ISO-8859-1?Q?Terje_Bergstr=F6m?=)
Date: Wed, 16 Jan 2013 10:01:15 +0200
Subject: [PATCH v2 03/10] ARM: dt: tegra30: Add clock information
In-Reply-To: <1357891289-23500-3-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
 <1357891289-23500-3-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50F65E4B.8040409@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.01.2013 10:01, Prashant Gaikwad wrote:
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 6765646..c3e129a 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
>  		gr3d {
>  			compatible = "nvidia,tegra30-gr3d";
>  			reg = <0x54180000 0x00040000>;
> +			clocks = <&tegra_car 24>;
>  		};

In Tegra3, 3D has two clocks. I believe you'd need to add <&tegra_car
98> here.

Terje
