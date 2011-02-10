From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Feb 2011 09:29:15 +0100
Subject: Machine ID question
In-Reply-To: <d6ddc34c-a962-4f4d-80b7-fc789606d899@VA3EHSMHS031.ehs.local>
References: <d6ddc34c-a962-4f4d-80b7-fc789606d899@VA3EHSMHS031.ehs.local>
Message-ID: <20110210082915.GV27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 02:23:07PM -0700, John Linn wrote:
> I used the form to create a new machine ID for the new Xilinx platform
> in anticipation of 
> the code making it into the mainline sometime in the future.
> 
> The proposed patches are using ARCH_XILINX in the Kconfig.
You should use MACH_XILINX in the patches.  There are some ARCH_... in
the machine db, but I think nowadays you cannot (and should not) create
them there.

> 
> Below is the line that it created when I clicked on this link:
> http://www.arm.linux.org.uk/developer/machines/download.php
> 
> xilinx			MACH_XILINX		XILINX
> 3343
> 
> Did I hose it up as the form wasn't completely clear to me (if I needed
> to enter ARCH_XILINX)?
> 
> Thanks,
> John
> 
> 
> 
> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may be
hmm, I'm at least not named explicitly, still I think the intention of
your mail was to get an answer.  IMHO it's not very sensible to add this
footer on postings to public mailing lists.

> proprietary, privileged or copyrighted under applicable law. If you
> are not the intended recipient, do not read, copy, or forward this
> email message or any attachments. Delete this email message and any
> attachments immediately.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
