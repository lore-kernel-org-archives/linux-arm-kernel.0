From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 23 Aug 2011 10:25:38 +0530
Subject: [PATCH] dmaengine: at_hdmac: add device tree probe
In-Reply-To: <4E4A9BD8.1040302@atmel.com>
References: <1312549120-22266-1-git-send-email-nicolas.ferre@atmel.com>
	<20110807040932.GF7667@ponder.secretlab.ca>
	<4E4A9BD8.1040302@atmel.com>
Message-ID: <1314075338.22120.3.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-16 at 18:33 +0200, Nicolas Ferre wrote:
> [..]
> 
> Grant, Vinod,
> 
> Don't you think it would make sense to generalize nr-channels and maybe
> also the capabilities properties for other dmaengine drivers?
> I have seen other dmaengine drivers taking the number of channels from
> platform data so that would make sense.
> It would be new dmaengine device tree properties, but on the other hand,
> I do not know if code can also be centralized for handling of those
> properties... maybe it is better to let drivers deal with them if
> required...
> 
We already having this discussion and how to change capabilities etc to
make thing more easy and transparent, See the approaches taken by Jassi
and Linus W

-- 
~Vinod
