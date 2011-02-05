From: John.Linn@xilinx.com (John Linn)
Date: Sat, 5 Feb 2011 09:49:59 -0700
Subject: [PATCH 0/4] ARM: Basic Xilinx Support
In-Reply-To: <20110205164700.GF29411@n2100.arm.linux.org.uk>
References: <eab51420-2be9-429a-8c59-76b3206bc15e@VA3EHSMHS033.ehs.local>
	<20110205164700.GF29411@n2100.arm.linux.org.uk>
Message-ID: <365f10c8-62ea-4d8e-ac7a-b15eb5584ffd@VA3EHSMHS033.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, February 05, 2011 9:47 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
glikely at secretlab.ca
> Subject: Re: [PATCH 0/4] ARM: Basic Xilinx Support
> 
> On Sat, Feb 05, 2011 at 09:08:40AM -0700, John Linn wrote:
> > This patch series adds very basic support for the Xilinx ARM
platform.
> > The entire patch set must be used. I only broke it up into logical
> > pieces to make the review easier (I hope).
> 
> It's actually a question of patch ordering - if patch 1 comes at the
> end, the other patches are just putting the files in place.  Until
> patch 1 is in place, none of it will be built.
> 
> If it's necessary to split stuff in this manner, it's quite usual for
> the configuration/makefile additions to come last in the series to
> avoid build errors half way through.

I can reorder them and put 1 last in the patch set.

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
