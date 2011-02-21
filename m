From: John.Linn@xilinx.com (John Linn)
Date: Mon, 21 Feb 2011 07:41:18 -0700
Subject: Machine ID question
In-Reply-To: <20110220130420.GD14495@n2100.arm.linux.org.uk>
References: <d6ddc34c-a962-4f4d-80b7-fc789606d899@VA3EHSMHS031.ehs.local>
	<20110210082915.GV27982@pengutronix.de>
	<201102141612.17340.alexander.stein@systec-electronic.com>
	<20110220130420.GD14495@n2100.arm.linux.org.uk>
Message-ID: <15649513-b696-4075-9b29-006a7ea8de00@VA3EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Sunday, February 20, 2011 6:04 AM
> To: Alexander Stein
> Cc: linux-arm-kernel at lists.infradead.org; John Linn; Uwe Kleine-K?nig
> Subject: Re: Machine ID question
> 
> On Mon, Feb 14, 2011 at 04:12:16PM +0100, Alexander Stein wrote:
> > On Thursday 10 February 2011, 09:29:15 Uwe Kleine-K?nig wrote:
> > > On Wed, Feb 09, 2011 at 02:23:07PM -0700, John Linn wrote:
> > > > I used the form to create a new machine ID for the new Xilinx
> platform
> > > > in anticipation of
> > > > the code making it into the mainline sometime in the future.
> > > >
> > > > The proposed patches are using ARCH_XILINX in the Kconfig.
> > >
> > > You should use MACH_XILINX in the patches.  There are some ARCH_...
> in
> > > the machine db, but I think nowadays you cannot (and should not)
> create
> > > them there.
> >
> > Uhm, the last entry in the db was created today (14th Feb). Is there
> a reason
> > why there no new entries should be created?
> 
> huh?
> 
> The machine registry hands out MACH_foo identifiers.  It used to hand
> them out as ARCH_foo identifiers, but we decided that was misleading -
> it's dealing with machines, not architectures.  So a MACH_ prefix is
> more correct than an ARCH_ prefix.

Thanks Russell, yea I figured that out after I had sent this out.

Appreciate the help,

John


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
