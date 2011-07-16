From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 09:01:40 +0900
Subject: [PATCH V2 12/12] ASoC: Samsung: Update DMA interface
In-Reply-To: <20110713235709.GE9770@opensource.wolfsonmicro.com>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
	<1310546857-6304-13-git-send-email-kgene.kim@samsung.com>
	<20110713235709.GE9770@opensource.wolfsonmicro.com>
Message-ID: <034301cc434b$8f0eecf0$ad2cc6d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Wed, Jul 13, 2011 at 05:47:37PM +0900, Kukjin Kim wrote:
> 
> > -static inline bool s3c_dma_has_circular(void)
> > +static inline bool dma_has_circular(void)
> >  {
> >  	return false;
> >  }
> 
> The namespacing here doesn't look great, this is still a Samsung
> specific internal API.
> 

OK, will keep it.

> Otherwise this looks good.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
