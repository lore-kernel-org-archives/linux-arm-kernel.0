From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 8 Dec 2017 16:13:16 +0530
Subject: [PATCH v3] ARM: davinci: fix mmc entries in dm365's dma_slave_map
In-Reply-To: <20171208103558.24494-1-amery@hanoverdisplays.com>
References: <20171208103558.24494-1-amery@hanoverdisplays.com>
Message-ID: <a36ac53c-8c66-a2f9-4483-bf67ffacf860@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 December 2017 04:05 PM, Alejandro Mery wrote:
> fix mmc entries in dm365's dma_slave_map to match the actual device names
> 
> Fixes: 0c750e1fe481 ("ARM: davinci: dm365: Add dma_slave_map to edma")
> Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>

Applied to fixes branch of my tree.

Thanks,
Sekhar
