From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 15:38:04 +0000
Subject: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
In-Reply-To: <20141215153529.GC11764@sirena.org.uk>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
 <548EDDCD.4060203@samsung.com>
 <20141215153529.GC11764@sirena.org.uk>
Message-ID: <20141215153804.GK20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 03:35:29PM +0000, Mark Brown wrote:
> On Mon, Dec 15, 2014 at 02:10:37PM +0100, Krzysztof Koz?owski wrote:
> > Few days ago I posted similar patch:
> > https://lkml.org/lkml/2014/12/5/268
> > but no one have picked it up.
> 
> > Anyway the fix of yours seems fine to me.
> 
> I don't mind either way, it just seemed to be easier to report the bug
> with a patch.  If Jeorg is busy perhaps it can go via the arm64 tree,
> the issue is triggered by the addition of the platform there?

Can I pass the buck to arm-soc, as they're handling arm64 platform code?

It seems sensible to merge the fix via the same tree that introduced the
breakage.

Will
