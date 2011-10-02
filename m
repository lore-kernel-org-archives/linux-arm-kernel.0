From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 17:09:26 +0100
Subject: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
In-Reply-To: <CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-5-git-send-email-arnd@arndb.de>
	<CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
Message-ID: <20111002160926.GB12323@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 05:56:07PM +0200, Bjarne Steinsbo wrote:
> Arnd,
> 
> Ref http://www.spinics.net/lists/linux-omap/msg57274.html
> 
> Don't get me wrong.  This is not about you "stealing" my patch, or
> anything like that.  But look also at thread starting at
> http://www.spinics.net/lists/linux-omap/msg57667.html Also a patch
> that I have posted previously.  Something is not right with the
> workflow when bugs are identified, patches are submitted, then
> ignored, only for someone else to fix the same bug.  Enough said.

That is where re-sending is important.  Don't throw patches over the wall
and then forget them - that's precisely how this happens.

Consider who has the higher workload, and who ends up dealing with many
many many emails, and realise that the options for those of us who receive
patches are either to drop patches, or have an endlessly growing backlog
of patches when things get busy.

Unless we drop patches, things can get pretty rediculous - consider the
effect of a backlog of one month worth of patches would cause...
