From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Jun 2011 22:24:12 -0700
Subject: [PATCH v2 1/4] gpio: gpio-mxc: add gpio driver for Freescale MXC
	architecture
In-Reply-To: <1306985632-18820-2-git-send-email-shawn.guo@linaro.org>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
	<1306985632-18820-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTinwnoAA-p2+b_Q--NFjHfKCG81d9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 8:33 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Add gpio-mxc driver by copying arch/arm/plat-mxc/gpio.c into
> drivers/gpio with the following changes.
>
> ?* Use readl/writel to replace mach-specific accessors
> ? __raw_readl/__raw_writel
>
> ?* Migrate to platform driver by adding .probe function
>
> ?* Add a list to save all mx2 ports references, so that
> ? mx2_gpio_irq_handler can walk through all interrupt status
> ? registers
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
