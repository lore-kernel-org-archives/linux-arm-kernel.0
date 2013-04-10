From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Apr 2013 14:59:07 +0200
Subject: [PATCH RESEND] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <516541EB.8080404@samsung.com>
References: <51642dab.e844440a.0ad1.ffffc13f@mx.google.com>
 <310101ce35d7$00e7e000$02b7a000$%kim@samsung.com>
 <516541EB.8080404@samsung.com>
Message-ID: <201304101459.07263.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 April 2013, Sylwester Nawrocki wrote:
> On 04/10/2013 12:34 PM, Kukjin Kim wrote:
> > Kukjin Kim wrote:
> >>
> >> From: Kukjin Kim <kgene.kim@samsung.com>
> >>
> >> As we discussed in mailing list, non-DT for EXYNOS SoCs will not be
> >> supported from v3.10. This patch removes regarding files for non-DT
> >> including board files.
> >>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> It looks OK to me.

Ok. I am currently rebuilding my exynos multiplatform series on top of the
branches merged yesterday, but keeping ATAGS support alive there.

Should I rebase on top of this patch instead?

	Arnd
