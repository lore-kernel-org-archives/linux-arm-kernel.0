From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Mar 2016 19:48:53 +0530
Subject: [PATCH 5/7] mtd: provide helper to prepare buffers for DMA
 operations
In-Reply-To: <1457435715-24740-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1457435715-24740-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457435715-24740-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160308141853.GQ11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 12:15:13PM +0100, Boris Brezillon wrote:
>  
> +#ifdef CONFIG_HAS_DMA

Shouldn't this be CONFIG_DMA_ENGINE as you are preparing these descriptors
for DMA transfer?

-- 
~Vinod
