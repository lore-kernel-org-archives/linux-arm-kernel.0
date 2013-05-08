From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 12:39:07 -0700
Subject: [REGRESSION] SLAB allocator (on Zynq)
In-Reply-To: <9d9b2266-e09e-4366-80ef-3df5db775f25@TX2EHSMHS033.ehs.local>
References: <9d9b2266-e09e-4366-80ef-3df5db775f25@TX2EHSMHS033.ehs.local>
Message-ID: <20130508193906.GC32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* S?ren Brinkmann <soren.brinkmann@xilinx.com> [130508 12:26]:
> Hi,
> 
> I compiled the latest kernel for Zynq and ran into issues when the SLAB
> allocator is selected. Booting crashes early with a NULL pointer
> dereference (boot log attached).
> Switching to the SLUB allocator resolves the issue (boot log attached).

There's a fix for this now in lkml thread
"[GIT PULL] SLAB changes for v3.10":

http://lkml.org/lkml/2013/5/8/374#

Regards,

Tony
