From: John.Linn@xilinx.com (John Linn)
Date: Fri, 18 Feb 2011 06:59:47 -0700
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <20110218090625.GA3203@pulham.picochip.com>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>
	<1297872716-13353-2-git-send-email-john.linn@xilinx.com>
	<1297872716-13353-3-git-send-email-john.linn@xilinx.com>
	<e58673f5-2881-4820-b5cd-99e8ef294ed5@VA3EHSMHS024.ehs.local>
	<20110217100126.GD22961@pulham.picochip.com>
	<2fdc2d92-486e-4319-866f-3882938363c3@VA3EHSMHS026.ehs.local>
	<20110218090625.GA3203@pulham.picochip.com>
Message-ID: <625bb321-106e-432a-b8d1-bdc9012fd18d@VA3EHSMHS016.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jamie Iles [mailto:jamie at jamieiles.com]
> Sent: Friday, February 18, 2011 2:06 AM
> To: John Linn
> Cc: Jamie Iles; linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; catalin.marinas at arm.com; glikely at secretlab.ca;
arnd at arndb.de
> Subject: Re: [PATCH V3 3/4] ARM: Xilinx: base header files and
assembly macros
> 
> On Thu, Feb 17, 2011 at 06:19:09PM -0700, John Linn wrote:
> > > > +#define PHYS_OFFSET             0x0
> > >
> > > This should be PLAT_PHYS_OFFSET and could do with being surrounded
> > with
> > > UL() e.g.
> > >
> > > #define PLAT_PHYS_OFFSET	UL(0x00000000)
> >
> > This doesn't build with 2.6.38-rc5, am I missing something?
> >
> > PHYS_OFFSET is still needed from what I can tell, but maybe I
overlooked
> > something.
> 
> The change is queued up in Russell's devel branch for the dynamic p2v
> and will be in 2.6.39.  For a patch series like this it's probably
worth
> developing off of linux-next[1].  This contains all of the trees that
> will be mereged into the next kernel so carries the bigger changes
like
> dynamic p2v.

My hope was to get into 2.6.38 and maybe that was not realistic.  If
it's too late
for 2.6.38 then I'll revise the patch for this branch.

Any thoughts Russell based on where we are?

Thanks for the insight.
John

> 
> Jamie
> 
> 1. git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
