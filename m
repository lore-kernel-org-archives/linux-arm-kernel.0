From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 21 Feb 2012 14:47:14 -0800
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC4AA@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote at Monday, February 13, 2012 2:43 PM:
> This series cleans-up mach/io.h and removes it for most platforms that have
> the same definitions of __io() and __mem_pci(). This mainly leaves platforms
> with PCI that need an io.h. Most of those can be converted once we have a
> fixed IO space mapping. OMAP io.h also remains as moving all the extra io.h
> stuff leaves it quite broken, so I'm leaving it to the OMAP folks to convert.

Sorry for the very slow response, but for the Tegra-specific parts,

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
