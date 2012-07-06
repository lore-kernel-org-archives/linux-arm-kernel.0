From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Fri, 6 Jul 2012 15:25:21 +0200
Subject: [PATCH 2/5] crypto: add Atmel AES driver
In-Reply-To: <20120706121719.GD4450@game.jcrosoft.org>
References: <1341163187-14946-1-git-send-email-eric@eukrea.com>
 <1341163187-14946-3-git-send-email-eric@eukrea.com>
 <20120706121719.GD4450@game.jcrosoft.org>
Message-ID: <20120706152521.5145f1aa@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

Le Fri, 6 Jul 2012 14:17:19 +0200,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :
> > +	u8	buf_in[ATMEL_AES_DMA_THRESHOLD] __aligned(sizeof(u32));
> can you allocate it
> > +	int	dma_in;
> > +	struct atmel_aes_dma	dma_lch_in;
> > +
> > +	u8	buf_out[ATMEL_AES_DMA_THRESHOLD] __aligned(sizeof(u32));
> ditto
> 
Why is that preferred to allocate dynamicaly these buffers (we are
talking of 2 x 16 bytes buffers) ?

> otherwise looks good
> 
thanks

Eric
