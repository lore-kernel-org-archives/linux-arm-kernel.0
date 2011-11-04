From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 4 Nov 2011 13:29:15 -0700
Subject: [PATCH v2 1/8] arm/tegra: initial device tree for tegra30
In-Reply-To: <1320242948-21061-2-git-send-email-pdeschrijver@nvidia.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4E3D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Wednesday, November 02, 2011 8:09 AM:
> This patch adds the initial device tree for tegra30
...
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
...
> +	intc: interrupt-controller at 50041000 {
> +		compatible = "nvidia,tegra30-gic", "nvidia,tegra20-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = < 0x50041000 0x1000 >,
> +		< 0x50040100 0x0100 >;

The indentation of that last line isn't quite right; I think the < are
usually aligned.

-- 
nvpublic
