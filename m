From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 16 Apr 2013 11:10:32 +0200
Subject: [PATCH 2/3] i2c: at91: convert to
 dma_request_slave_channel_compat()
In-Reply-To: <1366028217-5037-3-git-send-email-ludovic.desroches@atmel.com>
References: <1366028217-5037-1-git-send-email-ludovic.desroches@atmel.com>
 <1366028217-5037-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20130416091032.GA16978@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 02:16:56PM +0200, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Use generic DMA DT helper. Platforms booting with or without DT populated are
> both supported.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Applied to for-next, thanks!
