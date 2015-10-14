From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2015 12:35:53 -0700
Subject: [PATCHv2] ARM: OMAP3: clock: remove un-used core dpll re-program
 code
In-Reply-To: <1444823356-30324-1-git-send-email-t-kristo@ti.com>
References: <1444823356-30324-1-git-send-email-t-kristo@ti.com>
Message-ID: <20151014193552.GI10113@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [151014 04:52]:
> Remove the OMAP3 core DPLL re-program code, and the associated SRAM
> code that does the low-level programming of the DPLL divider, idling
> of the SDRAM etc.
> 
> This code was never fully implemented in the kernel; things missing
> were driver side handling of core clock changes (they need to account
> for their functional clock rate being changed on-the-fly), and the whole
> framework required for handling this. Thus, there is not much point
> to keep carrying the low-level support code either.

Thanks applying into omap-for-v4.4/cleanup.

Tony
