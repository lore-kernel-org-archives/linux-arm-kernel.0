From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Nov 2017 11:30:00 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <20171107021724.GB23638@arm.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106184753.xyj7xmlrzbfgovqz@sirena.co.uk>
 <20171107021724.GB23638@arm.com>
Message-ID: <20171107113000.y6bwknno56pdc62j@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 02:17:25AM +0000, Will Deacon wrote:
> On Mon, Nov 06, 2017 at 06:47:53PM +0000, Mark Brown wrote:
> > On Mon, Nov 06, 2017 at 04:30:41AM -0800, kernelci.org bot wrote:

> > There's several arm64 boots failing in -next at the minute, including
> > qemu - the last success seems to have been 20171017 which isn't terribly
> > helpful, obviously -next was spotty in October:

> There is a known boot failure due to 83e3c48729d9:

> http://lkml.kernel.org/r/20171102141210.gu4cwpoq2e6o7liu at black.fi.intel.com

> There's a patch there which appears to fix the problem, but it's not yet
> in next (and it needs to go via -mm).

Ugh, right.  It'd be good to get this in soon as it's making the boot
reports very hard to use and obscuring any other arm64 boot failures.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/dec1f6eb/attachment.sig>
