From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 24 Jan 2012 12:57:21 -0800
Subject: [PATCH V1] arm: tegra: dma: not required to move requestor when
 stopping.
In-Reply-To: <1327392649-27605-1-git-send-email-ldewangan@nvidia.com>
References: <1327392649-27605-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB81E5F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laxman Dewangan wrote at Tuesday, January 24, 2012 1:11 AM:
> It is not require to move the requestor of dma to INVALID
> option before stopping dma.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

I know that Laxman has checked with the HW engineers, and they see no
reason to do this. I was originally worried about hung FIFOs preventing
an in-progress DMA from completely without the removed code, but according
to HW, that isn't a concern.

-- 
nvpublic
