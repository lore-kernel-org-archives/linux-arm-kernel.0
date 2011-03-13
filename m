From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 13 Mar 2011 19:34:02 +0100
Subject: [PATCH v2 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <20110313171033.GA1413@ucw.cz>
References: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
	<201103131329.19793.marek.vasut@gmail.com>
	<20110313171033.GA1413@ucw.cz>
Message-ID: <201103131934.02152.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 March 2011 18:10:34 Pavel Machek wrote:
> Hi!
> 
> > > > > > > This patch is a part of similar mozzwald's patch which was
> > > > > > > based on GPSFan and rkdavis work.
> > > > > > 
> > > > > > Noone knows what/who is "mozzwald" or "rkdavis" or "GPSFan", the
> > > > > > comment for this patch is irelevant and has zero information
> > > > > > value.
> > > > > 
> > > > > Heh, I can add 'from Zipit Z2 community', I don't know their actual
> > > > > names nor mail addresses.
> > > > 
> > > > That's not the point. The point is the comment has zero value, it
> > > > doesn't describe the change.
> > > 
> > > Credit where credit is due. Yes, it is polite to thank original
> > > authors.
> > 
> > Doesn't it remind you of something ... ?
> > 
> > http://lwn.net/Articles/195643/
> > 
> > Maybe their true identity should be there as well.
> 
> This is credits, not signed-off-by, and I don't think this has similar
> trade secrets risks...

Actually it does ... how to connect the USB UDC is under Aeronix NDA (even the 
fact the UHC pins are on the connector is under NDA ;-) )

Cheers

> 								Pavel
