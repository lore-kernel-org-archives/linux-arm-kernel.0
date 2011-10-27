From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 27 Oct 2011 12:45:56 -0700
Subject: [PATCH 1/6] arm/tegra: initial device tree for tegra30
In-Reply-To: <1319561644-6160-2-git-send-email-pdeschrijver@nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B499C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, October 25, 2011 10:54 AM:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
>
> This patch adds the initial device tree for tegra30

It'd be nice if you could configure git send-email so it knows your name;
that way the From email header will include it.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> new file mode 100644
> index 0000000..3550b9a
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -0,0 +1,128 @@
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "NVIDIA Tegra 30";

Separately later, I don't suppose you could send a patch to add a model
field to tegra20.dtsi too?

Otherwise, this patch seems fine.

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
