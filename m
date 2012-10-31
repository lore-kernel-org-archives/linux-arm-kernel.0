From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 09:34:28 -0700
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <1351695517-5636-3-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
Message-ID: <20121031163428.GF12739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [121031 08:00]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation of moving gic code to drivers/irqchip, remove the direct
> platform dependencies on gic_raise_softirq. Move the setup of
> smp_cross_call into the gic code. Now that all platforms are using IPI#0
> for core wakeup, create a common wakeup ipi function.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

The omap changes look OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
