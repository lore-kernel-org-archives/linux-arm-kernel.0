From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 19 May 2011 16:26:08 +0530
Subject: [PATCH 0/2] Consolidate zone adjustment
In-Reply-To: <20110511162450.GF5315@n2100.arm.linux.org.uk>
References: <20110511162450.GF5315@n2100.arm.linux.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CFDCF12@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 21:54:50, Russell King - ARM Linux wrote:
> This patch mini-series consolidates the adjustment to system zones
> which some of our platforms require.  Rather than having each
> platform/machine class specify ISA_DMA_THRESHOLD, MAX_DMA_ADDRESS
> and an arch_adjust_zones function, they really only need to provide
> a single sizing definition, which in this series will be called
> ARM_DMA_ZONE_SIZE.

Boot tested this series on DaVinci DA850.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
