From: Trond.Myklebust@netapp.com (Trond Myklebust)
Date: Mon, 10 Jan 2011 12:20:35 -0500
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <4D2B3D03.8050504@pengutronix.de>
References: <1294268808.2952.18.camel@heimdal.trondhjem.org>
	<1294270104.16957.73.camel@mulgrave.site>
	<1294335614.22825.154.camel@mulgrave.site>
	<1294336054.2905.1.camel@heimdal.trondhjem.org>
	<AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>
	<1294426405.2929.23.camel@heimdal.trondhjem.org>
	<20110107190229.GX31708@n2100.arm.linux.org.uk>
	<1294427467.4895.66.camel@mulgrave.site>
	<1294505384.4181.14.camel@heimdal.trondhjem.org>
	<1294528551.4181.19.camel@heimdal.trondhjem.org>
	<20110110105019.GC24920@pengutronix.de>
	<1294676734.3349.10.camel@heimdal.trondhjem.org>
	<4D2B3D03.8050504@pengutronix.de>
Message-ID: <1294680035.3349.19.camel@heimdal.trondhjem.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-10 at 18:08 +0100, Marc Kleine-Budde wrote: 
> On 01/10/2011 05:25 PM, Trond Myklebust wrote:
> > On Mon, 2011-01-10 at 11:50 +0100, Uwe Kleine-K?nig wrote: 
> >> Hi Trond,
> >>
> >> On Sat, Jan 08, 2011 at 06:15:51PM -0500, Trond Myklebust wrote:
> >>> ----------------------------------------------------------------------------------- 
> >> It would be great if you could add a "8<" in the line above next time.
> >> Then git-am -c does the right thing (at least I think so).
> > 
> > Sorry. I wasn't aware of that particular idiom. So something like
> > 
> > 8<------------------------------------------------------------
> > From: Trond Myklebust <Trond.Myklebust@netapp.com>
> > Subject: .....
> 
> Yes.
> 
> From "man git-mailinfo":
> "A line that mainly consists of scissors (either ">8" or "8<") and
> perforation (dash "-")"
> 
> BTW:
> Is this patch a candidate for stable?

Yes. I'm planning on sending it to the stable list after Linus merges it
into mainline.

-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust at netapp.com
www.netapp.com
