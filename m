From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Aug 2014 16:21:44 +0100
Subject: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
In-Reply-To: <b172f93e-b2fb-4cf4-a2de-d2ca62cdb83f@BN1BFFO11FD016.protection.gbl>
References: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
 <20140813123343.GR17528@sirena.org.uk>
 <b172f93e-b2fb-4cf4-a2de-d2ca62cdb83f@BN1BFFO11FD016.protection.gbl>
Message-ID: <20140816152144.GT28623@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 03:21:29PM +0200, Michal Simek wrote:
> On 08/13/2014 02:33 PM, Mark Brown wrote:

> > Would it not be better to do this as a tree wide or at least subsystem
> > wide sweep with something like cocinelle?

> Feel free to use cocinelle for fixing this everywhere.
> For me was just easier to fix all xilinx drivers to ensure
> that none else will copy it for new drivers.

I'd expect people would be more likely to copy a random driver for the
subsystem they're working with than specifically a Xilinx driver...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/8bb6f379/attachment.sig>
