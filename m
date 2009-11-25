From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 17:34:58 +0000
Subject: [PATCH v2 07/17] ARM: dma-mapping: no need to clean
	overlapping cache lines on invalidate
In-Reply-To: <20091125163119.GB5136@n2100.arm.linux.org.uk>
References: <E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
	<E1NCZ7s-0002A3-0R@rmk-PC.arm.linux.org.uk>
	<1259151582.30270.61.camel@pc1117.cambridge.arm.com>
	<20091125163119.GB5136@n2100.arm.linux.org.uk>
Message-ID: <20091125173458.GI5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 04:31:19PM +0000, Russell King - ARM Linux wrote:
> In fact, I've made the decision.  I'm not merging this for the upcoming
> merge window.  It will wait another cycle to give us time to properly
> sort this problem out in a sane way, rather than rushing through with
> a half baked solution.

Actually, I'll merge the first four patches, since they don't cause any
major changes to the existing API, and just cleanup what we already have.
However, the rest are currently too volatile to merge.
