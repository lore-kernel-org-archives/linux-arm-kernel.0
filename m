From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 15 Jun 2013 11:20:30 +0900
Subject: [PATCH 00/28] Twenty eight patches big Exynos cleanup
In-Reply-To: <5750530.AyJQs5JHPZ@wuerfel>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
 <5750530.AyJQs5JHPZ@wuerfel>
Message-ID: <172301ce696e$e87f9f00$b97edd00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Friday 14 June 2013 21:32:36 Tomasz Figa wrote:
> >
> > As I promised, I am doing some spring (or rather summer) cleaning
> > of Exynos- and Samsung- related code.
> >
> > This first part consists mostly of removing dead code remaining after
> > removal of ATAGS support for Exynos, but several patches cleans up
> > other things found by the way.
> >
> > See particular patches for more detailed description.
> >
> > On Exynos4210-based Trats board:
> > Tested-by: Tomasz Figa <t.figa@samsung.com>
> >
> > Build tested every patch with s3c6400_defconfig, s5pv210_defconfig
> > and exynos_defconfig.
> 
> Great stuff. I unfortunately did almost the exact same patch since I
> did not know you were on it too. Yours looks better in some details,
> and your patch descriptions are /much/ better than my single large
> patch.
> 
> I'll try to cross-check the two series to see if there is anything
> you missed that was in my patch set.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

OK, let me take Tomasz's patches with your ack.

Thanks,
- Kukjin
