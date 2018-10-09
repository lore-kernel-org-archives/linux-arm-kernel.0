From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Oct 2018 09:06:12 +0200
Subject: [PATCH v4 0/8] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <2688131645a34eeda96894e154bba8d0@svr-chch-ex1.atlnz.lc>
References: <20180112012755.20495-1-chris.packham@alliedtelesis.co.nz>
 <1525338355.17782.21.camel@pengutronix.de>
 <2688131645a34eeda96894e154bba8d0@svr-chch-ex1.atlnz.lc>
Message-ID: <20181009070612.f3zrygvoj2xoeook@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

On Thu, May 03, 2018 at 08:54:36PM +0000, Chris Packham wrote:
> On 03/05/18 21:22, Jan L?bbe wrote:
> > On Fri, 2018-01-12 at 14:27 +1300, Chris Packham wrote:
> >> I've found some time to address Borislav's comments (I think I've got them
> >> all). The patches affected are 3/8 and 7/8. The changes are all reasonably
> >> cosmetic and I can confirm with the addition of 8/8 that the (mc) EDAC
> >> reporting works on Armada-38x.
> >>
> >> The current plan is for these to go in via the ARM tree once appropriate
> >> Reviews/Acks have been given.
> > 
> > I've finally found some time to look at this again. :)
> > 
> > As far as I can see, Borislav has reviewed the edac bits and Rob has
> > review the binding for marvell,ecc-enable. I'm not sure where it got
> > stuck though. Russell wanted to merge the whole series? Or am i missing
> > something?
> > 
> 
> Yes I was expecting it to come in via the ARM tree. It may have got lost 
> in the noise of the merge window. I checked a few times but I didn't 
> want to add to the noise.
> 
> Given that it's been a while: ping.

During an internal review of some patches in a BSP I stumbled over this
series.

I noticed that some patches (at least 1 and 2) don't have your S-o-b.
Patch 4 doesn't have it as last entry.

Didn't look in more detail, but maybe fix this formalism (which for sure
will prevent application of this series) and resend on top of a recent
tree?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
