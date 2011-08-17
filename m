From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 17 Aug 2011 14:07:37 +0530
Subject: [PATCH v3] amba: consolidate PrimeCell magic
In-Reply-To: <1313569846-22902-1-git-send-email-linus.walleij@stericsson.com>
References: <1313569846-22902-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CABb+yY0eMp5OgGPGmvyz6jE8jZgR2yVdR3RjcEpo6wHOyDYTdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 2:00 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Since three drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway. Delete the primecell ID check in
> common/pl330.c since it will soon only be used from the amba_bus
> driver in drivers/dma, which is already doing the same check
> when probing in drivers/amba/bus.c.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: H Hartley Sweeten <hartleys@visionengravers.com>
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

thnx
