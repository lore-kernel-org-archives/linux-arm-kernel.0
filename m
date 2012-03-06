From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 06 Mar 2012 17:24:12 +0530
Subject: [PATCH v3 2/2] dmaengine: Add support for multiple descriptors
 for imx-dma.
In-Reply-To: <1330676927-7330-1-git-send-email-javier.martin@vista-silicon.com>
References: <1330676927-7330-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1331034852.24656.197.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-03-02 at 09:28 +0100, Javier Martin wrote:
> dmaengine specifies the possibility that several descriptors
> can be queued for transfer. It also indicates that tasklets
> must be used for DMA callbacks.
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
Applied this and 1/2 or previous one

-- 
~Vinod
