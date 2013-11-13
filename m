From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Nov 2013 14:54:41 +0000
Subject: [PATCH] dmaengine: Add support for BCM2835.
In-Reply-To: <20131113133536.GZ8834@intel.com>
References: <527D1DDA.2040004@koalo.de> <20131108181743.GR2493@sirena.org.uk>
 <20131113050017.GO8834@intel.com>
 <20131113125111.GE878@sirena.org.uk>
 <20131113133536.GZ8834@intel.com>
Message-ID: <20131113145441.GQ878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 07:05:36PM +0530, Vinod Koul wrote:
> On Wed, Nov 13, 2013 at 12:51:11PM +0000, Mark Brown wrote:

> > I'm probably going to be looking at that at some point, though perhaps
> > Martin will get to it since he seems to be looking at this.

> Okay sounds good. This will also help in streamline the implementations..

Yes, though I think some of the stuff Martin was talking about will need
changes to the dmaengine APIs.  He was wanting to reuse DMA lists which
currently dmaengine needs to have built up each time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/5844b38d/attachment-0001.sig>
