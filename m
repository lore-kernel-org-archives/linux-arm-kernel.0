From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Nov 2013 16:30:55 +0000
Subject: [PATCH] dmaengine: Add support for BCM2835.
In-Reply-To: <20131113143101.GD8834@intel.com>
References: <527D1DDA.2040004@koalo.de> <20131108181743.GR2493@sirena.org.uk>
 <20131113050017.GO8834@intel.com>
 <20131113125111.GE878@sirena.org.uk>
 <20131113133536.GZ8834@intel.com>
 <20131113145441.GQ878@sirena.org.uk>
 <20131113143101.GD8834@intel.com>
Message-ID: <20131113163055.GV878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 08:01:01PM +0530, Vinod Koul wrote:
> On Wed, Nov 13, 2013 at 02:54:41PM +0000, Mark Brown wrote:

> > Yes, though I think some of the stuff Martin was talking about will need
> > changes to the dmaengine APIs.  He was wanting to reuse DMA lists which
> > currently dmaengine needs to have built up each time.

> Can you elobrate a bit more on what you guys want to do here?

He wants to be able to submit a descriptor to the hardware more than
once to save on the costs of of constructing the descriptor.  I'm not
convinced this is a huge benefit most of the time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/6700c5ef/attachment.sig>
