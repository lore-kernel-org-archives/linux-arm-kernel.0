From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 16:42:00 +0100
Subject: [PATCH 58/62] ARM: exynos: add missing include of linux/module.h
In-Reply-To: <027101cf43f4$18b17d00$4a147700$@samsung.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-59-git-send-email-arnd@arndb.de>
 <027101cf43f4$18b17d00$4a147700$@samsung.com>
Message-ID: <201403211642.01108.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Kukjin Kim wrote:
> Arnd Bergmann wrote:
> > 
> > After the restructuring of the module.h and init.h headers,
> > we now need to include this explicitly here.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tomasz Figa <tomasz.figa@gmail.com>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Arnd,
> 
> If you want me to take this fixes for Samsung stuff into samsung tree,
> please let me know.

I think it's easier for me to keep the 62 fixes together as a series
this time.

When I find new bugs later on, it may be better for you and the
other platform maintainers to pick those up.

	Arnd
