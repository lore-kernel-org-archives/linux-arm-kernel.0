From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 08:53:45 -0700
Subject: [PATCH 00/11] Minimum set of omap serial patches to fix merge
 window breakage
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <20121016155345.GP15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121016 03:16]:
> 
> There are two options to resolve this.  The first one is to revert this
> patch to bring the driver back down to the pre-merge window state.  The
> other is to apply this series of patches, which frankly I don't think
> is -rc material, even with the above regressions.

Yes reverting it is the way to go as we discussed in some off-list
emails. I think everybody agrees that this is too intrusive for the
-rc series :)

Regards,

Tony
