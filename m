From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Sep 2014 08:54:49 -0700
Subject: Exynos build failure in -next allmodconfig
In-Reply-To: <5418267E.8070501@gmail.com>
References: <E1XTTy1-0000vT-NC@cassiel.sirena.org.uk>
 <20140915163458.GS7960@sirena.org.uk>
 <20140915175709.GE12361@n2100.arm.linux.org.uk>
 <541822AC.8040805@samsung.com> <5418267E.8070501@gmail.com>
Message-ID: <20140916155449.GK7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 02:01:02PM +0200, Tomasz Figa wrote:

> I think the problematic case here is v6+v7 multiplatform, where even
> though CONFIG_ARCH_EXYNOS is defined, compiler flags for lowest common
> denominator (v6) must be used. Using appropriate macros should fix the
> problem indeed.

Right, multiplatform ends up generating such a configuration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/004087a2/attachment.sig>
