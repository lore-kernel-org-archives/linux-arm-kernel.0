From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 8 Jun 2011 15:48:32 +0200
Subject: [PATCH v4] [media] at91: add Atmel Image Sensor Interface
	(ISI) support
In-Reply-To: <1307497219-21496-1-git-send-email-josh.wu@atmel.com>
References: <1307497219-21496-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20110608134832.GB17584@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:40 Wed 08 Jun     , Josh Wu wrote:
> This patch is to enable Atmel Image Sensor Interface (ISI) driver support.
> - Using soc-camera framework with videobuf2 dma-contig allocator
> - Supporting video streaming of YUV packed format
> - Tested on AT91SAM9M10G45-EK with OV2640
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
looks fine
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
