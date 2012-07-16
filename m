From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 16 Jul 2012 12:08:03 +0530
Subject: [PATCH 07/11] dmaengine: at_hdmac: add a few const qualifiers
In-Reply-To: <1342182734-321-9-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
 <1342182734-321-9-git-send-email-y>
Message-ID: <1342420683.1726.46.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-13 at 14:32 +0200, y at pengutronix.de wrote:
> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> This prepares of_device_id.data becoming const. Without this change
> the following warning would occur:
> 
> 	drivers/dma/at_hdmac.c: In function 'at_dma_get_driver_data':
> 	drivers/dma/at_hdmac.c:1228: warning: return discards qualifiers from pointer target type
Applied, thanks.

By now, you should know git-send-mail asks for sender name and don't hit
"y". Bitten once, am careful about it :D

-- 
~Vinod
