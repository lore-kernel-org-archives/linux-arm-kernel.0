From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Jun 2016 00:00:12 -0700
Subject: [RESEND PATCHv2 03/28] ARM: OMAP2+: omap_device: create clock
 alias purely from DT data
In-Reply-To: <1465844702-12200-4-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-4-git-send-email-t-kristo@ti.com>
Message-ID: <20160628070011.GD28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> This avoids the need to add most of the clock aliases under
> drivers/clk/ti/clk-xyz.c files.

This is a nice improvment, probably best to queu this along
with the rest of the series via the clock tree:

Acked-by: Tony Lindgren <tony@atomide.com>

Or please let me know if you want me to pick this separately.

Regards,

Tony
