From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Jun 2015 13:25:03 +0200
Subject: [RESEND PATCH v4 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150615100920.GB32199@gondor.apana.org.au>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150615100920.GB32199@gondor.apana.org.au>
Message-ID: <20150615132503.69ec2cbb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Mon, 15 Jun 2015 18:09:20 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jun 12, 2015 at 09:15:57AM +0200, Boris Brezillon wrote:
> >
> > +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> > +			 DMA_TO_DEVICE);
> > +	if (ret < 0)
> 
> This function returns zero on error, not negative.  See
> Documentation/DMA-API-HOWTO.txt for details.

Yep, I'll fix that.

Thanks for pointing this out.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
