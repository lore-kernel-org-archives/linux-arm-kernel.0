From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Oct 2012 14:54:52 +0100
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <20121022135024.GN21164@n2100.arm.linux.org.uk>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121022130556.GM21164@n2100.arm.linux.org.uk>
 <20121022132711.GE4477@opensource.wolfsonmicro.com>
 <20121022135024.GN21164@n2100.arm.linux.org.uk>
Message-ID: <20121022135452.GJ4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 02:50:24PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 22, 2012 at 02:27:11PM +0100, Mark Brown wrote:

> > If we're worrying about that there's the larger point that the effect of
> > this patch is to make HAVE_CLK meaningless as there will be no platform
> > for which it's not true.  I was just leaving HAVE_CLK alone for now
> > ready to circle around on it if we ever manage to get the enabling bit
> > sorted.

> Are you sure that all architectures are fine with having that permanently
> enabled?  What about nommu architectures?

There's already stubs present so the main use case for depending on it
(checking if code can build) is already covered without requiring that
the API actually be built on all platforms.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/9983472a/attachment-0001.sig>
