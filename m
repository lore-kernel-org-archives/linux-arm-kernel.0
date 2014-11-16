From: kgene@kernel.org (Kukjin Kim)
Date: Sun, 16 Nov 2014 10:20:01 +0900
Subject: [PATCH v8 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <2593372.vOeyyAKq5M@wuerfel>
References: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com>
 <54660DAE.9090601@samsung.com> <2593372.vOeyyAKq5M@wuerfel>
Message-ID: <00ef01d0013b$716f1d30$544d5790$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Friday 14 November 2014 15:11:58 Marek Szyprowski wrote:
> >
> > I assume that after all comments from previous versions, no more changes
> > are needed
> > to this patchset and I would really like to have it queued to v3.19.
> >
> > Arnd, Olof: could you take this patchset thought arm-soc tree? It already
> > contains all dependencies.
> >
> > Kukjin: could you ack this patchset?
> 
> I'd rather see this merged through Russell's tree, as most of the patches
> are for core code, and only three are for the platform.
> 
> For the exynos patches:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
I'm also fine on this series for the exynos stuff:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

And agree with Arnd's suggestion to handle in rmk tree.
(I think seems this has no dependency with samsung tree)

Thanks,
Kukjin
