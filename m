From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Feb 2012 23:36:00 +0000
Subject: [PATCH 5/9] ARM: EXYNOS: add board file for SMDK5250
In-Reply-To: <069401cce71e$56bffe80$043ffb80$%kim@samsung.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <20120201093423.GA3002@mudshark.cambridge.arm.com>
 <069401cce71e$56bffe80$043ffb80$%kim@samsung.com>
Message-ID: <201202092336.00524.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 February 2012, Kukjin Kim wrote:
> Will Deacon wrote:
> > 
> > On Wed, Feb 01, 2012 at 08:50:23AM +0000, Olof Johansson wrote:
> > > On Tue, Jan 31, 2012 at 8:20 PM, Kyungmin Park <kmpark@infradead.org>
> > wrote:
> > > > As I remember only DT based board file is acceptable for mainline?
> > >
> > > For a new SoC family like 5250 it would be much preferred to only add
> > > device-tree enabled boards.
> > 
> As I commented, I'd like to support both dt and non-dt for EXYNOS5250 and
> I'm saying EXYNOS5250 DT patches will be submitted next time again.

I think it would be much better to start with just the DT based platform
for exynos5 and leave out the atag based platform.

	Arnd
