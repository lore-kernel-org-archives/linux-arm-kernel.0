From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 15:56:15 +0000
Subject: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
In-Reply-To: <20141215153804.GK20738@arm.com>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
 <548EDDCD.4060203@samsung.com>
 <20141215153529.GC11764@sirena.org.uk>
 <20141215153804.GK20738@arm.com>
Message-ID: <20141215155615.GD11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 03:38:04PM +0000, Will Deacon wrote:
> On Mon, Dec 15, 2014 at 03:35:29PM +0000, Mark Brown wrote:

> > I don't mind either way, it just seemed to be easier to report the bug
> > with a patch.  If Jeorg is busy perhaps it can go via the arm64 tree,
> > the issue is triggered by the addition of the platform there?

> Can I pass the buck to arm-soc, as they're handling arm64 platform code?

> It seems sensible to merge the fix via the same tree that introduced the
> breakage.

Sure, just resending to them...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/e01a2f66/attachment.sig>
