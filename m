From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Feb 2013 12:15:43 +0000
Subject: [GIT PULL 2/4] ARM broadcast timer updates for 3.9
In-Reply-To: <20130205223728.GA14851@quad.lixom.net>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-2-git-send-email-will.deacon@arm.com>
 <20130204152426.GG17786@n2100.arm.linux.org.uk>
 <20130205223728.GA14851@quad.lixom.net>
Message-ID: <20130207121543.GF15387@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Feb 05, 2013 at 10:37:28PM +0000, Olof Johansson wrote:
> On Mon, Feb 04, 2013 at 03:24:26PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 04, 2013 at 01:55:29PM +0000, Will Deacon wrote:
> > > This is the second part of the kvm-related series and moves ARM over to
> > > the generic timer broadcast implementation, currently queued by tglx in
> > > -tip.
> > > 
> > > Please note that, due to this dependency, this branch contains mainline
> > > up to ~-rc6, so you may want to keep it on a separate branch to avoid
> > > pulling in a bunch of unrelated changes from -tip.
> > 
> > Both 1 and 2 pulled and merged.  I'll wait 24 hours before pushing this out
> > so that the nightly build can have a go at it before the new devel-stable
> > branch gets published.
> 
> Sounds good. I'll deal with 3 and 4 once you're happy with 1/2 and
> they're out, since we need the same as base.

1 and 2 are now in rmk's devel-stable branch, so we should be good to go
with the third series. As highlighted by me and Rob, the fourth set likely
needs a new base in arm-soc to minimise both the diffstat and number of
merge conflicts.

Cheers,

Will
