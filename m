From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Aug 2011 11:00:37 +0100
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110815100037.GD26827@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 11:55:04AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway.
> 
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Samsung folks: I cannot find a defconfig that actually compiles
> this driver in, can you help me testing it so I didn't break
> anything, and Ack if it looks OK? Thanks.

Why not convert these to use the amba_bus driver?
