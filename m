From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 2 Jan 2015 16:20:42 -0500
Subject: [GIT PULL] Fixes for 3.19, #2
In-Reply-To: <20150102160818.GB6708@lunn.ch>
References: <20150102160818.GB6708@lunn.ch>
Message-ID: <20150102212042.GC15589@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

Much better!  One small note, below:

On Fri, Jan 02, 2015 at 05:08:18PM +0100, Andrew Lunn wrote:
> Hi Arnd
> 
> Here is a second set of fixes for the next -rc. It contains a single
> patch to fix an Opps with the kirkwood netbig LED driver. This patch
> has been sent to the LED maintainers a couple of times, with
> reminders, but there has been no response. So we would like to take it
> via mvebu->arm-soc. We informed the LED maintainers about this plan,
> and they are Cc: to this pull request, just so everybody knows what is
> going on.
> 

I usually add a short blurb in here saying that this is an incremental
pull request from tags/mvebu-fixes-3.19 up to tags/mvebu-fixes-3.19-2 on
the mvebu/fixes branch.

I add that so the arm-soc maintainers easily have a clear idea what they
are pulling in and what it is based on.  For some reason request-pull
doesn't add 'tags/mvebu-fixes-3.19' into the below info even when you
specify it as the start on the cli...

thx,

Jason.

> Thanks
> 	Andrew
> 
> The following changes since commit d4b0833a65e8b9fc58d992ba0cc89cad1580db31:
> 
>   ARM: mvebu: Fix pinctrl configuration for Armada 370 DB (2014-12-21 06:01:05 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-2
> 
> for you to fetch changes up to bb682e44c77731711818c2cf9f6d4bc277207eee:
> 
>   leds: netxbig: fix oops at probe time (2014-12-30 10:39:23 -0600)
> 
> ----------------------------------------------------------------
> 2nd set of fixes for 3.19:
> 
> leds: netxbig: fix oops at probe time
> 
> ----------------------------------------------------------------
> Simon Guinot (1):
>       leds: netxbig: fix oops at probe time
> 
>  drivers/leds/leds-netxbig.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
