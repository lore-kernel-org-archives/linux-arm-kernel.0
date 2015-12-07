From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Dec 2015 15:35:18 +0100
Subject: [PATCH 02/10] ARM: debug-ll: reorganize mvebu debug uart config
In-Reply-To: <566585F7.4020606@linaro.org>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-3-git-send-email-arnd@arndb.de>
 <566585F7.4020606@linaro.org>
Message-ID: <2409568.kE8oxrYXxZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 13:13:27 Daniel Thompson wrote:
> > @@ -511,17 +512,23 @@ choice
> >                 Plathome OpenBlocks AX3, when using the original
> >                 bootloader.
> >
> > +               This option will not work on older Marvell platforms
> > +               (Kirkwood, Dove, MV78xx0, Orion5x), which should  piock
> > +               the "new bootloader" variant.
> > +
> 
> s/piock/pick/
> 
> 

Fixed, thanks!

	Arnd
