From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 10 Jul 2015 13:30:02 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix bug about channel configuration
In-Reply-To: <1434550946-27750-1-git-send-email-ludovic.desroches@atmel.com>
References: <1434550946-27750-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150710080002.GC836@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 04:22:26PM +0200, Ludovic Desroches wrote:
> When using descriptor view 2 or higher, we don't write the configuration
> into AT_XDMAC_CC register because this configuration will be fetch from
> the descriptor. Unfortunately, the PROT bit is not updated with this
> method, we have to do it manually before enabling the channel.
> 
Applied, thanks

-- 
~Vinod
