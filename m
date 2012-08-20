From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Aug 2012 20:51:59 +0200
Subject: [PATCH 04/11] pinctrl: mvebu: add pinctrl driver for Armada 370
In-Reply-To: <50327B8F.3050503@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYNZar7865-T12J37h3AWA9-8R1R5tymuOhaB0b3ddEAA@mail.gmail.com>
 <50326A60.1070007@gmail.com> <20120820193622.4e539451@skate>
 <50327B8F.3050503@gmail.com>
Message-ID: <20120820205159.63001848@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 20 Aug 2012 20:01:51 +0200,
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :

> > If that's fine with you, then I would prefer if we keep the single
> > MACH_ARMADA_370_XP symbol for now, so that your pinctrl set of
> > patches does not depend on something else. We would do the small
> > Kconfig option refactoring as a follow-up set of patches. Thoughts?
> 
> Despite any objections, I will remove all arch/arm/*/Kconfig patches
> from pinctrl patch set.

Ok, fine with me, but we'll have to send separate patches for those,
then.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
