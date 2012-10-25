From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 25 Oct 2012 16:38:00 +0530
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <5089033F.9040100@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
 <1351074456-25863-3-git-send-email-b32955@freescale.com>
 <1351138689.5263.68.camel@vkoul-udesk3> <5088D336.7040206@freescale.com>
 <1351145272.7077.8.camel@vkoul-udesk3>  <5089033F.9040100@freescale.com>
Message-ID: <1351163280.7077.11.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-25 at 17:15 +0800, Huang Shijie wrote:
> yes. I have to setup the register. Could you told me which API is the 
> right API?
dmaengine_slave_config() should be used to send the slave specfic
parameters
> 
> It seems to the mxs-dma needs a patch again. 
Yes definitely :)

-- 
Vinod Koul
Intel Corp.
