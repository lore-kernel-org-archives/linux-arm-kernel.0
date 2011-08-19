From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <1313654311-2283-1-git-send-email-linus.walleij@stericsson.com>
References: <1313654311-2283-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <000801cc5e30$3a612d30$af238790$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway. Delete the primecell ID check in
> common/pl330.c since it is only used from the amba_bus driver
> in drivers/dma, which is already doing the same check when
> probing in drivers/amba/bus.c.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> Cc: Viresh Kumar <viresh.kumar@st.com>
> Acked-by: H Hartley Sweeten <hartleys@visionengravers.com>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
