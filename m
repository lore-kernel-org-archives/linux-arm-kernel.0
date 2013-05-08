From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 8 May 2013 13:12:05 -0700
Subject: [REGRESSION] SLAB allocator (on Zynq)
In-Reply-To: <20130508193906.GC32546@atomide.com>
References: <9d9b2266-e09e-4366-80ef-3df5db775f25@TX2EHSMHS033.ehs.local>
 <20130508193906.GC32546@atomide.com>
Message-ID: <35a77b0e-59cc-4fee-81cf-20c059462d12@DB8EHSMHS016.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 12:39:07PM -0700, Tony Lindgren wrote:
> Hi,
> 
> * S?ren Brinkmann <soren.brinkmann@xilinx.com> [130508 12:26]:
> > Hi,
> > 
> > I compiled the latest kernel for Zynq and ran into issues when the SLAB
> > allocator is selected. Booting crashes early with a NULL pointer
> > dereference (boot log attached).
> > Switching to the SLUB allocator resolves the issue (boot log attached).
> 
> There's a fix for this now in lkml thread
> "[GIT PULL] SLAB changes for v3.10":
> 
> http://lkml.org/lkml/2013/5/8/374#
Thanks for the quick response and apologies for not having it found
myself earlier.
With that patch it works again.

	Thanks,
	S?ren
