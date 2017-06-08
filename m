From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Jun 2017 01:28:25 -0700
Subject: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
In-Reply-To: <20170607222711.6kdhuvkymiseootn@earth>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
 <20170607222711.6kdhuvkymiseootn@earth>
Message-ID: <20170608082825.GG3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [170607 15:30]:
> I guess you can drop omap2_init_devices() completly?

We still have omap_init_sti() left there, but it's
just static inline void omap_init_sti(void) {} :)

So yeah will remove that too.

Regards,

Tony
