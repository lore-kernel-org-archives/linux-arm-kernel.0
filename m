From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 14 Jun 2011 14:20:14 +0900
Subject: [PATCH] dma-mapping: Undefine dma_map_single(),
	etc if CONFIG_HAVE_DMA_ATTRS is defined
In-Reply-To: <1308025989-877-1-git-send-email-pullip.cho@samsung.com>
References: <1308025989-877-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <005501cc2a52$c05df650$4119e2f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pullip.cho at samsung.com wrote:
> 
> From: KyongHo Cho <pullip.cho@samsung.com>
> 
> If <asm/dma-mapping.h> includes <asm-generic/dma-mapping-common.h>,
> dma_map_single() become defined recursively when CONFIG_HAVE_DMA_ATTRS
> is not defined.
> Since dma_map_*_attrs() are defined in <linux/dma-mapping.h>, those
> in <asm-generic/dma-mapping-common.h> must be not defined
> if CONFIG_HAVE_DMA_ATTRS is not defined.
> 
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> CC: Joerg Roedel <joerg.roedel@amd.com>
> CC Arnd Bergmann <arnd@arndb.de>
> 
> Change-Id: Ib99ee2b355dbe679263ce2e4e27d6219148c8338

Please don't use this here.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
