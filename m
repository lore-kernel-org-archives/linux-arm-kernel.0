From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 15:51:39 +0100
Subject: [PATCH v8 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <54660DAE.9090601@samsung.com>
References: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com>
 <54660DAE.9090601@samsung.com>
Message-ID: <2593372.vOeyyAKq5M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 15:11:58 Marek Szyprowski wrote:
> 
> I assume that after all comments from previous versions, no more changes 
> are needed
> to this patchset and I would really like to have it queued to v3.19.
> 
> Arnd, Olof: could you take this patchset thought arm-soc tree? It already
> contains all dependencies.
> 
> Kukjin: could you ack this patchset?

I'd rather see this merged through Russell's tree, as most of the patches
are for core code, and only three are for the platform.

For the exynos patches:

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
