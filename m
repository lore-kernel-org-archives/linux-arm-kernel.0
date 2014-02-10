From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Feb 2014 16:36:22 +0000
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <1392046242.3585.41.camel@x220>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk>
 <1392039072.3585.15.camel@x220>
 <20140210141255.GI1757@sirena.org.uk>
 <1392046242.3585.41.camel@x220>
Message-ID: <20140210163621.GA13533@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:30:42PM +0100, Paul Bolle wrote:
> On Mon, 2014-02-10 at 14:12 +0000, Mark Brown wrote:

> > Yes, that's correct.  Now, like I say think about what the symbol was
> > there for in the first place.

> So, next step: the Kconfig symbols MACH_SMDKV310 and MACH_SMDKC210 were
> removed in commit 383ffda2fa ("ARM: EXYNOS: no more support non-DT for
> EXYNOS SoCs"). That commit was part of v3.11. Correct?

Indeed, so we can see that these platforms were converted to use DT and
the symbols were removed as a result.  This means that a good fix here
is to ensure that the driver can be used with DT platforms.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/68f0308e/attachment.sig>
