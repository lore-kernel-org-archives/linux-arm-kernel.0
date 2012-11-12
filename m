From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 12 Nov 2012 11:14:41 +0100
Subject: [PATCH v3 0/6] ARM: EXYNOS: Add secure firmware support
In-Reply-To: <20121112095530.GF28327@n2100.arm.linux.org.uk>
References: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
 <006501cdc0a8$d880c990$89825cb0$%kim@samsung.com>
 <20121112095530.GF28327@n2100.arm.linux.org.uk>
Message-ID: <3879194.hz9mrTmL6z@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 of November 2012 09:55:30 Russell King - ARM Linux wrote:
> On Mon, Nov 12, 2012 at 04:39:28PM +0900, Kukjin Kim wrote:
> > (+ Russell King)
> 
> I think there's still an amount of work to do here; it's not a generic
> interface at the moment because it makes some assumptions about how
> things are done (eg, it assumes that there _will_ be a CPU boot
> register; that is not always true.
> 
> Moreover, the 'cpu' arguments given seem to be uncertain whether they're
> logical CPU numbers or physical CPU numbers.
> 
> Lastly, where is this interface actually documented?  It's just a bunch
> of code _without_ _any_ documentation.  That means people will interpret
> it differently, and it'll get used differently from platform to
> platform.
> 
> Let's have some documentation on this.

Right, I will include documentation in next version of this patchset.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
