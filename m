From: John.Linn@xilinx.com (John Linn)
Date: Mon, 14 Feb 2011 07:46:02 -0700
Subject: Machine ID question
In-Reply-To: <20110210082915.GV27982@pengutronix.de>
References: <d6ddc34c-a962-4f4d-80b7-fc789606d899@VA3EHSMHS031.ehs.local>
	<20110210082915.GV27982@pengutronix.de>
Message-ID: <697e0ab2-c24d-4ad8-b293-1e86af31c28a@CH1EHSMHS014.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> Sent: Thursday, February 10, 2011 1:29 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Machine ID question
> 
> On Wed, Feb 09, 2011 at 02:23:07PM -0700, John Linn wrote:
> > I used the form to create a new machine ID for the new Xilinx platform
> > in anticipation of
> > the code making it into the mainline sometime in the future.
> >
> > The proposed patches are using ARCH_XILINX in the Kconfig.
> You should use MACH_XILINX in the patches.  There are some ARCH_... in
> the machine db, but I think nowadays you cannot (and should not) create
> them there.

Russell, should I change from ARCH_XILINX to MACH_XILINX in the V3 of my patchset?

> 
> >
> > Below is the line that it created when I clicked on this link:
> > http://www.arm.linux.org.uk/developer/machines/download.php
> >
> > xilinx			MACH_XILINX		XILINX
> > 3343
> >
> > Did I hose it up as the form wasn't completely clear to me (if I needed
> > to enter ARCH_XILINX)?
> >
> > Thanks,
> > John
> >
> >
> >
> > This email and any attachments are intended for the sole use of the
> > named recipient(s) and contain(s) confidential information that may be
> hmm, I'm at least not named explicitly, still I think the intention of
> your mail was to get an answer.  IMHO it's not very sensible to add this
> footer on postings to public mailing lists.

Agreed. Not my choice and will discuss more with others to see if I can 
get around it and still use corporate email.

> 
> > proprietary, privileged or copyrighted under applicable law. If you
> > are not the intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email message and any
> > attachments immediately.
> 
> Best regards
> Uwe

Thanks Uwe,

-- John

> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
