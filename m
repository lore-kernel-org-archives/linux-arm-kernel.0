From: John.Linn@xilinx.com (John Linn)
Date: Mon, 14 Feb 2011 07:42:24 -0700
Subject: [PATCH V2 3/4] ARM: Xilinx: base header files and assemblymacros
In-Reply-To: <20110212121609.GI15616@n2100.arm.linux.org.uk>
References: <1297270845-18802-1-git-send-email-john.linn@xilinx.com>
	<1297270845-18802-2-git-send-email-john.linn@xilinx.com>
	<1297270845-18802-3-git-send-email-john.linn@xilinx.com>
	<e19bc079-5f8a-4622-b7cd-668cede3cb97@VA3EHSMHS032.ehs.local>
	<20110212121609.GI15616@n2100.arm.linux.org.uk>
Message-ID: <1bbbc116-1107-46fe-8dbc-daa3c798d76e@VA3EHSMHS027.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, February 12, 2011 5:16 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org; catalin.marinas at arm.com;
> glikely at secretlab.ca
> Subject: Re: [PATCH V2 3/4] ARM: Xilinx: base header files and
assemblymacros
> 
> On Wed, Feb 09, 2011 at 10:00:44AM -0700, John Linn wrote:
> > +#ifndef __MACH_VMALLOC_H__
> > +#define __MACH_VMALLOC_H__
> > +
> > +#define VMALLOC_END       0xE0000000
> 
> Should have a UL suffix on this.

OK, easy to fix.

Thanks for another review Russell, appreciate your time and help.

-- John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
