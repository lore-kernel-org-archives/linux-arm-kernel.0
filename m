From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 13:05:56 +0100
Subject: [PATCH v10 2/2] dmaengine: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <20140728150911.GN3952@lukather>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140630142054.GA8756@leverpostej>
 <20140630151906.GG28647@lukather>
 <20140630153305.GA28740@leverpostej>
 <20140701072119.GH28647@lukather>
 <20140701124852.GB6064@leverpostej>
 <20140727184942.GL17528@sirena.org.uk>
 <20140728150911.GN3952@lukather>
Message-ID: <20140729120556.GS17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 05:09:11PM +0200, Maxime Ripard wrote:
> On Sun, Jul 27, 2014 at 07:49:42PM +0100, Mark Brown wrote:

> > There's supposed to be facilities appearing in the generic clock code
> > for specifying default clock tree configurations via the DT - it's quite
> > a common requirement after all.  It sounds like that should be able to
> > do the job here.  Not sure if these have gone in yet or not but there's
> > quite a bit of demand.

> As far as I'm aware, it's not been merged yet.

Well, another reason to push Mike about it then I guess - there are a
lot of these case cropping up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/d7dcd600/attachment.sig>
