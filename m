From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 12:08:41 +0000
Subject: [PATCH 3/9] clk: sunxi: remove stale Makefile entry
In-Reply-To: <20130215045404.11471.91270@quantum>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-4-git-send-email-arnd@arndb.de>
 <20130215045404.11471.91270@quantum>
Message-ID: <201302151208.41628.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Mike Turquette wrote:
> Quoting Arnd Bergmann (2013-02-14 14:26:52)
> > Patch 85a18198 "clk: sunxi: Use common of_clk_init() function"
> > removed the clk-sunxi.c file but left the Makefile entry, which
> > causes a build error in multi_v7_defconfig:
> > 
> > make[4]: *** No rule to make target `drivers/clk/clk-sunxi.o', needed by `drivers/clk/built-in.o'.
> > 
> > The obvious fix is to remove the extraneous line from the
> > Makefile.
> > 
> 
> The fix is correct.  I can't rebase my branch since there is an existing
> dependency with the tegra tree, so I have taken this patch as-is with
> the addition of my SoB.
> 

Ok, thanks!

	Arnd
