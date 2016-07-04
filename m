From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Jul 2016 07:32:48 -0700
Subject: [PATCHv2 2/5] ARM: OMAP2+: hwmod: fetch main_clk based on hwmod
 name
In-Reply-To: <1467630708-28498-1-git-send-email-t-kristo@ti.com>
References: <20160704065428.GS28140@atomide.com>
 <1467630708-28498-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160704143248.GU28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160704 04:14]:
> With the transition to hwmod module clocks, all hwmods will have
> their main clocks named <hwmod_name>_mod_ck. Use this info to
> fetch main_clk, and use it if found.
> 
> Also, if a main_clk is found based on the hwmod name, disable
> the direct PRCM modulemode access from hwmod.

Thanks for updating this, applying all into omap-for-v4.8/soc.

Regards,

Tony
