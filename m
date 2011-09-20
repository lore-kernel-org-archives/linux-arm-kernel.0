From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 20 Sep 2011 16:14:52 +0530
Subject: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Message-ID: <4E786EA4.9020900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 September 2011 10:07 PM, Russell King - ARM Linux wrote:
> This is a re-post of the previous patch series, but with an additional
> TLB flush to ensure that hte global TLB entry in the page tables is
> flushed out.  This is a flush of all TLB entries, but it could probably
> be more targetted if we need to.
> 
I have tried this seven patches + already merged 4 patches against RC4
and OMAP4 PM patches and they continue to work as expected.

I guess once Lorenzo confirms that his userspace segmentation faults
are fixed with the TLB flush updates, the series is good for the merge.

Regards
Santosh
