From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Feb 2016 14:02:57 +0000
Subject: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
In-Reply-To: <20160208131419.GA19598@localhost>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <56AF01B6.6030204@gmail.com> <20160208031134.GI2531@localhost>
 <3817335.PXCk0JfYDT@phil> <20160208131419.GA19598@localhost>
Message-ID: <20160208140257.GC7265@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 06:44:19PM +0530, Vinod Koul wrote:
> On Mon, Feb 08, 2016 at 10:27:04AM +0100, Heiko Stuebner wrote:

> > I think the more regular way is for the driver maintainer to take the 
> > driver-specific stuff and the devicetree parts going through the specific arm-
> > tree. But if you really want to take the whole series, for patches 4,5,6

> Yes but that causes cross tree dependencies, which looking at this won't be
> a big problem, so I can safely merge dmaengine changes and rest can go thru
> ARM tree.

Not for the DT stuff - since the DT is supposed to be a stable ABI there
really shouldn't be any hard dependencies on things outside the DT.

> Typically submitter should say which tree he/she prefers, which was not
> provided..

It's the norm for DT stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/42079e83/attachment.sig>
