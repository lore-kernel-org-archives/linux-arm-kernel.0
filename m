From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 18 Aug 2011 14:13:30 +0530
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <1313654311-2283-1-git-send-email-linus.walleij@stericsson.com>
References: <1313654311-2283-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E4CD0B2.3020802@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2011 1:28 PM, Linus WALLEIJ wrote:
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
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Acked-by: H Hartley Sweeten <hartleys@visionengravers.com>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Good One!!

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
