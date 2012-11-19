From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 10:52:10 +0000
Subject: [PATCH V3 4/5] arm: mm: Added support for PJ4B cpu and init
 routines
In-Reply-To: <50A9EA11.7050409@free-electrons.com>
References: <1352931637-3405-1-git-send-email-gregory.clement@free-electrons.com>
 <1352931637-3405-5-git-send-email-gregory.clement@free-electrons.com>
 <50A41BD3.9040509@free-electrons.com>
 <50A6B427.9080807@free-electrons.com>
 <20121119031210.GD22106@titan.lakedaemon.net>
 <50A9EA11.7050409@free-electrons.com>
Message-ID: <20121119105210.GD3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 08:13:05AM +0000, Gregory CLEMENT wrote:
> On 11/19/2012 04:12 AM, Jason Cooper wrote:
> > On Fri, Nov 16, 2012 at 10:46:15PM +0100, Gregory CLEMENT wrote:
> >> On 11/14/2012 11:31 PM, Gregory CLEMENT wrote:
> >>> Hello Russell,
> >>>
> >>> With the 2 changes I have done on according your comments
> >>> do you think you can give your acked-by for this patch?
> >>>
> >>
> >> Hello Russell,
> >>
> >> I didn't have any feedback from you for this version.
> >> If you are fine with this, could you give your Acked-by?
> >>
> >>
> > 
> > Gregory,
> > 
> > From the looks of things, Russell has his head wrapped around buggy
> > sound driver code for the CuBox.  Perhaps Will Deacon or Catalin Marinas
> > would care to weigh in?  I'm reluctant to take the series without an
> > Acked-By from at least one of them.
> 
> 
> I am fine with this as Will already have done the review.

I reviewed the thing, so you can add:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

However, if Russell wants to take this via his tree then perhaps it's best
for arm-soc to pull a branch from him containing this, like we've done in the
past.

The alternative is to order the pull requests to Linus, but that sounds like
a bad idea (although I suspect the rest of your series still at least compiles
without this patch?).

Will
