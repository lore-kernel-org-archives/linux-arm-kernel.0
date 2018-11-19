From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Nov 2018 10:06:52 -0800
Subject: [PATCH] ARM: OMAP2+: timer: Remove obsolete inclusion of
 <asm/smp_twd.h>
In-Reply-To: <20181115095858.17530-1-geert+renesas@glider.be>
References: <20181115095858.17530-1-geert+renesas@glider.be>
Message-ID: <20181119180652.GT53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Geert Uytterhoeven <geert+renesas@glider.be> [181115 03:25]:
> As of commit d1dabab2841d546f ("ARM: OMAP2+: Clean up
> omap4_local_timer_init"), this header file is no longer used.

Applying into omap-for-v4.21/soc thanks.

Tony
