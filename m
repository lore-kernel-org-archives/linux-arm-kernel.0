From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 16 May 2012 16:00:37 +0200
Subject: [PATCH] mmc: atmel-mci: fix burst/chunk size modification 
Message-ID: <1337176838-24111-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch requires the following set of patches from slave-dma/next:

1dd1ea8 dmaengine: at_hdmac: take maxburst from slave configuration
b409ebf dmaengine: at_hdmac: remove ATC_DEFAULT_CTRLA constant
b89a9cb dmaengine: at_hdmac: remove some at_dma_slave comments


Regards

Ludovic
