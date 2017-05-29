From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 16:56:13 +0200
Subject: [PATCH 09/11] crypto: sun4i-ss: move from ablkcipher to skcipher
 API
In-Reply-To: <20170529144757.GA23017@Red>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
 <20170524190652.13278-10-antoine.tenart@free-electrons.com>
 <20170529144757.GA23017@Red>
Message-ID: <20170529145613.GA14148@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Mon, May 29, 2017 at 04:47:57PM +0200, Corentin Labbe wrote:
> On Wed, May 24, 2017 at 09:06:50PM +0200, Antoine Tenart wrote:
> > +			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
> > +				     CRYPTO_ALG_KERN_DRIVER_ONLY,
> 
> You add CRYPTO_ALG_KERN_DRIVER_ONLY on all flags which is unrelated to
> the patch description.

Right, I forgot to make an extra patch for this. I'll fix this (and the
other ones).

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/22cbf525/attachment.sig>
