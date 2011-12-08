From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 8 Dec 2011 10:03:38 -0800
Subject: [PATCH v6 10/10] arm/tegra: add support for tegra30 based board
 cardhu
In-Reply-To: <1323348254-29072-11-git-send-email-pdeschrijver@nvidia.com>
References: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
 <1323348254-29072-11-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B77A82@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, December 08, 2011 5:44 AM:
> Add support for the tegra30 based cardhu development board. Cardhu is a tablet
> formfactor reference design for tegra30. The patch provides a device tree for
> the board, updates Makefile.boot to build the dtb, includes the platform in
> Kconfig and updates board-dt.c.

It'd be nice to add status="disabled" to all the peripherals that aren't
hooked up on Cardhu, in the same way as the patches I recently posted for
all the Tegra20 boards. Still, I'm fine with doing that in a following
patch.

-- 
nvpublic
