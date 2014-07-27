From: broonie@kernel.org (Mark Brown)
Date: Sun, 27 Jul 2014 19:49:42 +0100
Subject: [PATCH v10 2/2] dmaengine: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <20140701124852.GB6064@leverpostej>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140630142054.GA8756@leverpostej>
 <20140630151906.GG28647@lukather>
 <20140630153305.GA28740@leverpostej>
 <20140701072119.GH28647@lukather>
 <20140701124852.GB6064@leverpostej>
Message-ID: <20140727184942.GL17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 01:48:52PM +0100, Mark Rutland wrote:
> On Tue, Jul 01, 2014 at 08:21:19AM +0100, Maxime Ripard wrote:

> > > It feels a little fragile to rely on the organisation of the clock tree
> > > and the naming thereof. If the IP block is ever reused on an SoC with a
> > > different clock tree layout then we have to handle things differently.
> > 
> > What do you suggest then?
> 
> I will admit that I don't have a better suggestion.
> 
> Without knowing which particular constraint on the mux parent clock we
> care about it's difficult to suggest anything useful.

There's supposed to be facilities appearing in the generic clock code
for specifying default clock tree configurations via the DT - it's quite
a common requirement after all.  It sounds like that should be able to
do the job here.  Not sure if these have gone in yet or not but there's
quite a bit of demand.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140727/4cb178f7/attachment.sig>
