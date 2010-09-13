From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 13 Sep 2010 07:55:49 +0200
Subject: Regression on UP ARM from commit
	e18d65f0500b95d8724b17d8ea9f1116cf390bbe
In-Reply-To: <AANLkTimC5Vz7x9+MNJcewijoyw=Nyr6WWP=YR8cxqarH@mail.gmail.com>
References: <AANLkTimC5Vz7x9+MNJcewijoyw=Nyr6WWP=YR8cxqarH@mail.gmail.com>
Message-ID: <20100913055549.GA14773@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Sep 12, 2010 at 11:47:39PM +0200, Linus Walleij wrote:
> commit e18d65f0500b95d8724b17d8ea9f1116cf390bbe
> "slub: Remove static kmem_cache_cpu array for boot"

In which tree have you found this commit? I cant find 
e18d65f0500b95d8724b17d8ea9f1116cf390bbe in Linus' (Torvalds) tree up to -rc4.

baruch

> made my ARM 926 UP system hang at boot, if I revert this (have
> to back out a lot of SLUB patches for that) it comes back up. (Same if I
> switch to SLAB.)
> 
> Any hints on how I can get patch around this in a nice way?

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
