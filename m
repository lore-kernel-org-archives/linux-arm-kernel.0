From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:07:59 -0700
Subject: [PATCH] ARM: OMAP: rx51: Fix a section mismatch warn
In-Reply-To: <1347460624-25259-1-git-send-email-shubhrajyoti@ti.com>
References: <1347460624-25259-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121008210759.GG13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shubhrajyoti D <shubhrajyoti@ti.com> [120912 07:38]:
> rx51_si4713_dev is referenced only from rx51_init_si4713.
> So the memory for rx51_si4713_dev can be safely freed after init.
> Also it references rx51_si4713_board_info which is __initdata_or_module.

Thanks applying into fixes.

Tony
