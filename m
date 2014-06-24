From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 11:02:20 +0100
Subject: [PATCH v2 2/3] drm/ttm: introduce dma cache sync helpers
In-Reply-To: <1403603667-11302-3-git-send-email-acourbot@nvidia.com>
References: <1403603667-11302-1-git-send-email-acourbot@nvidia.com>
 <1403603667-11302-3-git-send-email-acourbot@nvidia.com>
Message-ID: <20140624100220.GK32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 06:54:26PM +0900, Alexandre Courbot wrote:
> From: Lucas Stach <dev@lynxeye.de>
> 
> On architectures for which access to GPU memory is non-coherent,
> caches need to be flushed and invalidated explicitly at the
> appropriate places. Introduce two small helpers to make things
> easy for TTM-based drivers.

Have you run this with DMA API debugging enabled?  I suspect you haven't,
and I recommend that you do.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
