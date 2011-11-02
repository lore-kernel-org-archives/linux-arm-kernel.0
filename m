From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 2 Nov 2011 11:06:58 -0700
Subject: [PATCH] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173F9A46E5@HQMAIL01.nvidia.com>
References: <1320248292-22736-1-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A46E5@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4758@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Wednesday, November 02, 2011 10:39 AM:
> Peter De Schrijver wrote by Wednesday, November 02, 2011 9:38 AM:
> > Tegra30 has 1 extra legacy interrupt controller. Use the GIC ITLinesNumber
> > field to determine how many interrupt controllers we have and initialize
> > appropriately. Also make room for the extra tegra30 interrupts by moving
> > the GPIO IRQ base. This shouldn't affect existing code as it determines the
> > correct IRQ number for GPIOs using TEGRA_GPIO_TO_IRQ()
> >
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> After fixing one small issue I comment on below,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Also, both this and "arm/tegra: remove unused defines":

Tested-by: Stephen Warren <swarren@nvidia.com>

(on Tegra20 Seaboard/Springbank, not on Tegra30 Cardhu)

-- 
nvpublic
