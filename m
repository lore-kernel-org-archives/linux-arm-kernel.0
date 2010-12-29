From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 17:25:12 +0100
Subject: (arm-)global platform device registration functions
Message-ID: <20101229162512.GI14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

some time ago I started to dynamically allocate platform_devices for
arm/plat-mxc.  For that purpose I added many functions, see
arch/arm/plat-mxc/include/mach/devices-common.h [1].  Now arm/arch-mxs
want to do the same, so I wonder if it would be sensible to do something
like this more globally (either for arm or better kernel global).

Thoughts?

Best regards
Uwe

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-mxc/include/mach/devices-common.h;hb=HEAD

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
