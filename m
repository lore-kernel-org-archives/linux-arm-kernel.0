From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 5 Jan 2012 12:38:35 -0800
Subject: [PATCH v2] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <1325770305-21637-1-git-send-email-pdeschrijver@nvidia.com>
References: <1325770305-21637-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F17AB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, January 05, 2012 6:32 AM:
> Tegra30 has 1 extra legacy interrupt controller. Use the GIC ITLinesNumber
> field to determine how many interrupt controllers we have and initialize
> appropriately. Also make room for the extra tegra30 interrupts by moving
> the GPIO IRQ base. This shouldn't affect existing code as it determines the
> correct IRQ number for GPIOs using TEGRA_GPIO_TO_IRQ().

Due to a typo in ARM patch 7240/1, this current patch also relies on
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7271/1

-- 
nvpublic
