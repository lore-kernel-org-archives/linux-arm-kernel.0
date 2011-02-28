From: John.Linn@xilinx.com (John Linn)
Date: Mon, 28 Feb 2011 07:14:31 -0700
Subject: [PATCH V4 2/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <20110228111156.GB8751@pulham.picochip.com>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-2-git-send-email-john.linn@xilinx.com>
	<a7f0ed14-296f-450d-af78-6771cd7281d1@VA3EHSMHS022.ehs.local>
	<20110228111156.GB8751@pulham.picochip.com>
Message-ID: <7d2af02a-d0ab-49b4-a4f9-65718057dc9c@VA3EHSMHS030.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jamie Iles [mailto:jamie at jamieiles.com]
> Sent: Monday, February 28, 2011 4:12 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org; linux at arm.linux.org.uk;
> catalin.marinas at arm.com; glikely at secretlab.ca; jamie at jamieiles.com;
arnd at arndb.de; Kiran Sutariya
> Subject: Re: [PATCH V4 2/4] ARM: Xilinx: Adding timer support to the
platform
> 
> On Fri, Feb 18, 2011 at 11:14:39AM -0700, John Linn wrote:
> > The timer driver supports the Xilinx PS Timer Counter IP.
> >
> > Signed-off-by: Kiran Sutariya <kiran.sutariya@einfochips.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > ---
> 
> Looks nice to me.  It may be worth adding sched_clock() support to get
> better scheduler resolution in the future but that could come as a
> separate patch.

Yes will do that as an update patch later, good suggestion.

Thanks,
John

> 
> Jamie


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
