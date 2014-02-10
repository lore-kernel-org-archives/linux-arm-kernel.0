From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Feb 2014 16:30:42 +0100
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <20140210141255.GI1757@sirena.org.uk>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk> <1392039072.3585.15.camel@x220>
 <20140210141255.GI1757@sirena.org.uk>
Message-ID: <1392046242.3585.41.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-10 at 14:12 +0000, Mark Brown wrote:
> On Mon, Feb 10, 2014 at 02:31:12PM +0100, Paul Bolle wrote:
> > If so, to be absolutely sure we start from the same point: do you agree
> > that the above line now effectively reads
> >     depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || false || false)
> 
> > because there's neither a Kconfig symbol MACH_SMDKV310 nor a Kconfig
> > symbol MACH_SMDKC210?
> 
> Yes, that's correct.  Now, like I say think about what the symbol was
> there for in the first place.

So, next step: the Kconfig symbols MACH_SMDKV310 and MACH_SMDKC210 were
removed in commit 383ffda2fa ("ARM: EXYNOS: no more support non-DT for
EXYNOS SoCs"). That commit was part of v3.11. Correct?

Thanks for your patience.


Paul Bolle
