From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 02 Aug 2010 18:03:02 +1000
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100802074812.GM24084@amd.com>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de> <1280546124.1902.30.camel@pasglop>
	<20100802074812.GM24084@amd.com>
Message-ID: <1280736182.1902.55.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-02 at 09:48 +0200, Roedel, Joerg wrote:
> > Hrm, indeed I just noticed that. Pretty gross... it should definitly
> be
> > renamed, is will caused endless confusion with unrelated iommu.h and
> > iommu_* interfaces which represent something different.
> 
> The first direction to go should be trying to unify all the different
> iommu* interfaces into the iommu-api. The generic api will definitly
> need to be extended for that, but since it is an in-kernel interface
> thats no problem. 

Well, I suppose I'm the de-facto candidate to take care of the powerpc
side then :-)

I don't have the bandwidth right now, but I'll try to have a look when
time permits.

Cheers,
Ben.
