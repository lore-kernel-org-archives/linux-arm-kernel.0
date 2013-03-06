From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 6 Mar 2013 09:36:19 +0800
Subject: [PATCH v2 08/12] serial: mxs-auart: move to use generic DMA helper
In-Reply-To: <1362486244-24593-9-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
 <1362486244-24593-9-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130306013619.GC8260@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 08:24:00PM +0800, Shawn Guo wrote:
> With the generic DMA device tree helper supported by mxs-dma driver,
> client devices only need to call dma_request_slave_channel() for
> requesting a DMA channel from dmaengine.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial at vger.kernel.org


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
