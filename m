From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 21 Mar 2013 12:07:18 +0100
Subject: [PATCH v2 06/12] i2c: i2c-mxs: move to use generic DMA helper
In-Reply-To: <1362486244-24593-7-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
 <1362486244-24593-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130321110718.GG19297@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 08:23:58PM +0800, Shawn Guo wrote:
> With the generic DMA device tree helper supported by mxs-dma driver,
> client devices only need to call dma_request_slave_channel() for
> requesting a DMA channel from dmaengine.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c at vger.kernel.org

Yay, DMA helpers \o/ Assuming the helpers work, for the i2c driver:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks for doing this!
