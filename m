From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 26 Jan 2012 12:40:06 -0800
Subject: [PATCH v1 7/8] ARM: tegra: support for Tegra30 CPU powerdomains
In-Reply-To: <1327597641-7519-8-git-send-email-pdeschrijver@nvidia.com>
References: <1327597641-7519-1-git-send-email-pdeschrijver@nvidia.com>
 <1327597641-7519-8-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB8247C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, January 26, 2012 10:07 AM:
> Secondary CPU powerdomains can be powergated on Tegra30. Add the necessary
> functions to do this. This will be used to boot the secondary CPUs later on.

> diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c

> -int __init tegra_powergate_init(void)
...
> +int  __init tegra_powergate_init(void)

You added an extra space there; probably not really worth fixing unless
you repost for some other reason.

-- 
nvpublic
