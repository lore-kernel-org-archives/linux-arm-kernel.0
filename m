From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Nov 2012 17:18:06 -0800
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121127011805.GP5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@linaro.org> [121126 05:36]:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.

Cool. Seems to boot for omap1 and omap2+, so:

Tested-by: Tony Lindgren <tony@atomide.com>
