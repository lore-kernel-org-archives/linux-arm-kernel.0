From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2009 17:02:01 +0000
Subject: [PATCH v2 07/17] ARM: dma-mapping: no need to cleanoverlapping
	cache lines on invalidate
In-Reply-To: <20091125163119.GB5136@n2100.arm.linux.org.uk>
References: <20091125163119.GB5136@n2100.arm.linux.org.uk>
Message-ID: <1259168521.1367.9.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-11-25 at 16:31 +0000, Russell King - ARM Linux wrote:
> In fact, I've made the decision.  I'm not merging this for the upcoming
> merge window.  It will wait another cycle to give us time to properly
> sort this problem out in a sane way, rather than rushing through with
> a half baked solution.

That would be a good idea. But please try to publish a volatile branch
somewhere for testing this easily (maybe before getting into -next).

-- 
Catalin

P.S. I'm off for the rest of the week with very limited e-mail access.
