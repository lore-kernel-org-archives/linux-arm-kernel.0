From: tony@atomide.com (Tony Lindgren)
Date: Sun, 16 Jul 2017 23:01:02 -0700
Subject: [PATCH 0/2] mmc: omap: Remove Unused Code
In-Reply-To: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Message-ID: <20170717060101.GB10026@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [170714 05:48]:
> This patch series removes some code in omap_hsmmc.c
> and hsmmc.c and members from hsmmc.h and 
> hsmmc-omap.h which are not used anymore post 
> conversion to device-tree.

Hey that's nice! That gets us a bit closer removing the
old platform data for that driver.

Regards,

Tony
