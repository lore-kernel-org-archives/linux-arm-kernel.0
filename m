From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 18 Jan 2015 19:59:52 +0530
Subject: [PATCH] ARM: SAMSUNG: remove unused DMA infrastructure
In-Reply-To: <2398692.KpvgzHd6no@wuerfel>
References: <2398692.KpvgzHd6no@wuerfel>
Message-ID: <20150118142952.GP15411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 04:16:03PM +0100, Arnd Bergmann wrote:
> Everything uses dmaengine now, so there is no reason to
> keep this around any longer. Thanks to everyone who was involved
> in moving the users over to use the dmaengine APIs.
Very good indeed :)

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
