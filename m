From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 10:46:11 -0700
Subject: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
In-Reply-To: <20111002160926.GB12323@n2100.arm.linux.org.uk>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-5-git-send-email-arnd@arndb.de>
	<CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
	<20111002160926.GB12323@n2100.arm.linux.org.uk>
Message-ID: <20111003174610.GP6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111002 08:35]:
> On Sun, Oct 02, 2011 at 05:56:07PM +0200, Bjarne Steinsbo wrote:
> > Arnd,
> > 
> > Ref http://www.spinics.net/lists/linux-omap/msg57274.html
> > 
> > Don't get me wrong.  This is not about you "stealing" my patch, or
> > anything like that.  But look also at thread starting at
> > http://www.spinics.net/lists/linux-omap/msg57667.html Also a patch
> > that I have posted previously.  Something is not right with the
> > workflow when bugs are identified, patches are submitted, then
> > ignored, only for someone else to fix the same bug.  Enough said.
> 
> That is where re-sending is important.  Don't throw patches over the wall
> and then forget them - that's precisely how this happens.

Bjarne, sorry for accidentally dropping patches, that's not intentional.

Like Russell said, please follow through with your own patches and
repost and complain until the patches do get merged.

> Consider who has the higher workload, and who ends up dealing with many
> many many emails, and realise that the options for those of us who receive
> patches are either to drop patches, or have an endlessly growing backlog
> of patches when things get busy.
> 
> Unless we drop patches, things can get pretty rediculous - consider the
> effect of a backlog of one month worth of patches would cause...

Tools like patchwork.kernel.org help a bit, and especially the email
subject line containing magic the keyword "fix" might help avoiding
the duplicate work.

Regards,

Tony
