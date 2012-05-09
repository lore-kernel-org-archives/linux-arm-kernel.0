From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 May 2012 10:33:06 -0700
Subject: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
In-Reply-To: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20120509173305.GR5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120503 01:02]:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
 
I'll apply these into cleanup-timer branch now that we have the
related hwmod patches merged into devel-hwmod-data.

Regards,

Tony
