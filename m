From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 23 Jan 2015 16:32:54 +0900
Subject: [PATCH] ARM: SAMSUNG: remove unused DMA infrastructure
In-Reply-To: <20150118142952.GP15411@intel.com>
References: <2398692.KpvgzHd6no@wuerfel> <20150118142952.GP15411@intel.com>
Message-ID: <0d8e01d036de$cd1242b0$6736c810$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul wrote:
> 
> On Thu, Jan 15, 2015 at 04:16:03PM +0100, Arnd Bergmann wrote:
> > Everything uses dmaengine now, so there is no reason to
> > keep this around any longer. Thanks to everyone who was involved
> > in moving the users over to use the dmaengine APIs.
> Very good indeed :)
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
Very nice and thanks to you all guys.

I'll apply this clean-up in Samsung tree with Heiko's reviewed-by.

- Kukjin
