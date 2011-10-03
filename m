From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 3 Oct 2011 13:52:17 -0700
Subject: [PATCH v4 05/10] ARM: SoC: convert Tegra to SoC descriptor
In-Reply-To: <1317663356-5114-6-git-send-email-marc.zyngier@arm.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173A2C6DD0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote at Monday, October 03, 2011 11:36 AM:
> Convert Tegra to use the SoC descriptor to provide its SMP
> and CPU hotplug operations.

> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
...
> +struct arm_soc_desc tegra_soc_desc __initdata = {
> +	.name		= "nVIDIA Tegra",

Technically, we're supposed to say "NVIDIA" not "nVIDIA", but no need to
respin just for that! So,

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
