From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jul 2016 14:24:41 +0200
Subject: [PATCH] spi: s3c64xx: do not disable the clock while configuring
 the spi
In-Reply-To: <20160707095840.GH23620@samsunx.samsung>
References: <CGME20160707072419epcas1p3ba881fb9b3270eb8cde87380aea7bcf9@epcas1p3.samsung.com>
 <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
 <20160707095840.GH23620@samsunx.samsung>
Message-ID: <20160707122441.GP6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 06:58:41PM +0900, Andi Shyti wrote:

> sorry, I will re-send it because I should not remove the comments
> above.... in the future someone might wonder why it's multiplied
> by 2.

I already applied and published this, can you please send an incremental
patch fixing the issue?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/749cc072/attachment-0001.sig>
