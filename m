From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Jul 2014 09:51:38 +0200
Subject: [PATCH 1/3] ARM: exynos: remove unused <mach/memory.h>
In-Reply-To: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140722075138.GB28538@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

who takes care of this series?

In fact they are all orthogonal to each other.

The first patch

	ARM: exynos: remove unused <mach/memory.h>

has been reviewed and tested by Tomasz Figa and Sachin Kamat. Can the
Samsung people pick it up? Or armsoc?

Patch 2 (v2!)

	ARM: remove remaining definitions of PLAT_PHYS_OFFSET from <mach/memory.h>

touches several arch/arm/mach-*/include/mach/memory.h and
arch/arm/Kconfig. armsoc? Russell?

Patch 3 fixes a warning regarding nommu and touches the Kconfig entry
for Integrator and Renesas (non-multiplatform). armsoc?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
