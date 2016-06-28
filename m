From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Jun 2016 00:04:58 -0700
Subject: [RESEND PATCHv2 07/28] ARM: OMAP2+: timer: change order of hwmod
 data handling
In-Reply-To: <1465844702-12200-8-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-8-git-send-email-t-kristo@ti.com>
Message-ID: <20160628070457.GF28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> With the introduction of hwmod module clocks, the name of the hwmod
> main clk may not be available before hwmod setup, as hwmod setup
> may lookup the main clock dynamically based on the hwmod name.
> Thus, change the order of hwmod setup and main clock handling for
> the timer code, to make sure the main clock is going to be
> available.

Acked-by: Tony Lindgren <tony@atomidme.com>

Also for this one, please let me know if this can be picked
separately.

Tony
