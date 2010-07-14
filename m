From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Jul 2010 15:20:46 +0200
Subject: ARM defconfig files
In-Reply-To: <201007121634.04427.davidb@codeaurora.org>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<201007121605.32462.davidb@codeaurora.org>
	<AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
	<201007121634.04427.davidb@codeaurora.org>
Message-ID: <20100714132046.GA18343@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 04:34:04PM -0700, David Brown wrote:
> On Monday 12 July 2010 16:18:01 Linus Torvalds wrote:
> 
> > 2010/7/12 David Brown <davidb@codeaurora.org>:
> > >
> > > Do you have scripts or tools that you did this with, or is a manual
> > > process.  We're about to add several new (ARM) targets, and it'd be
> > > nice to be able to make small defconfigs for those targets as well.
> > 
> > Uwe posted it earlier in this thread as an attachement, and I put the
> > python script into the merge commit message too. And we should
> > probably put it somewhere in scripts too, and/or make a 'make' target
> > to create the small config files.
> > 
> > I pushed it all out, and tagged it as -rc5.
> 
> Got it, thanks.  I just pulled a bit soon.
> 
> It seems a bit brute force, probably not something I can make part of
> our regular build process, but I can definitely run it before sending
> patches out.
> 
> I wonder if there's a more efficient way of doing it that doesn't
> involve invoking make for each line of the file.  It at least
> shouldn't be necessary to actually build the kernel each time.
Note that no kernel is built at all, only the config is regenerated once
for each line.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
