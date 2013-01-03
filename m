From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 21:38:07 +0000
Subject: [PATCH v4 07/19] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <1357235668-9450-8-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-8-git-send-email-robherring2@gmail.com>
Message-ID: <201301032138.07460.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that the GIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Anton Vorontsov <avorontsov@mvista.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
