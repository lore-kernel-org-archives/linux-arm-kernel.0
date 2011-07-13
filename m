From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jul 2011 08:57:11 +0900
Subject: [PATCH V2 12/12] ASoC: Samsung: Update DMA interface
In-Reply-To: <1310546857-6304-13-git-send-email-kgene.kim@samsung.com>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
	<1310546857-6304-13-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110713235709.GE9770@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 05:47:37PM +0900, Kukjin Kim wrote:

> -static inline bool s3c_dma_has_circular(void)
> +static inline bool dma_has_circular(void)
>  {
>  	return false;
>  }

The namespacing here doesn't look great, this is still a Samsung
specific internal API.

Otherwise this looks good.
