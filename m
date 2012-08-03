From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Aug 2012 15:48:56 +0200
Subject: [PATCH 2/4] arm: plat-orion: make bridge_virt_base non-const to
 support DT use case
In-Reply-To: <201208031341.32744.arnd@arndb.de>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1343999430-31816-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <201208031341.32744.arnd@arndb.de>
Message-ID: <20120803154856.74a5368f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Fri, 3 Aug 2012 13:41:32 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> > +       u32 bridge_virt_base;
> >  
> >         /* If NULL, the default cpu_win_can_remap will be used, using
> >            the value in remappable_wins */
> 
> It would be nice to also change the type of this to void __iomem*, since you are
> already touching the bridge_virt_base.

Yeah, I was also thinking about this cleanup. Will rework my patch
series to include a patch fixing this before doing the other changes.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
