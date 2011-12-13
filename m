From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 16:24:29 -0800
Subject: [PATCHv11 5/8] ARM: OMAP2+: mux: add support for PAD wakeup
 interrupts
In-Reply-To: <1323713733-13115-6-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-6-git-send-email-t-kristo@ti.com>
Message-ID: <20111213002429.GN32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [111212 09:44]:
> OMAP mux now parses active wakeup events from pad registers and
> calls corresponding hwmod ISRs once a wakeup is detected. This is
> accomplished by registering an interrupt handler for PRCM IO event,
> which is raised every time the HW detects wakeups.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This will need to be updated once we are using the pinctrl
framework, for now this looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
