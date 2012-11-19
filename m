From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Nov 2012 09:19:12 +0000
Subject: [PATCH V3 4/5] arm: mm: Added support for PJ4B cpu and init
 routines
In-Reply-To: <20121119031210.GD22106@titan.lakedaemon.net>
References: <1352931637-3405-1-git-send-email-gregory.clement@free-electrons.com>
 <1352931637-3405-5-git-send-email-gregory.clement@free-electrons.com>
 <50A41BD3.9040509@free-electrons.com> <50A6B427.9080807@free-electrons.com>
 <20121119031210.GD22106@titan.lakedaemon.net>
Message-ID: <20121119091912.GC3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 10:12:10PM -0500, Jason Cooper wrote:
> On Fri, Nov 16, 2012 at 10:46:15PM +0100, Gregory CLEMENT wrote:
> > On 11/14/2012 11:31 PM, Gregory CLEMENT wrote:
> > > Hello Russell,
> > > 
> > > With the 2 changes I have done on according your comments
> > > do you think you can give your acked-by for this patch?
> > > 
> > 
> > Hello Russell,
> > 
> > I didn't have any feedback from you for this version.
> > If you are fine with this, could you give your Acked-by?
> > 
> > 
> 
> Gregory,
> 
> >From the looks of things, Russell has his head wrapped around buggy
> sound driver code for the CuBox.  Perhaps Will Deacon or Catalin Marinas
> would care to weigh in?  I'm reluctant to take the series without an
> Acked-By from at least one of them.

Well, I would like to say - it should go through my tree, as it's generic
ARM changes, and as very little (even generic stuff) seems to come through
my tree anymore.  But that's going to make the remainder of your patches
difficult to merge.
