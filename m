From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 27 Aug 2012 15:43:04 -0700
Subject: [PATCH] ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER
In-Reply-To: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
References: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <CAMQu2gxZBq0wMw4rgbFpDT2pmA83ULKAJ-Mwv+VKvQQZMRQ4Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 3:26 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Currently, omap2_sync32k_clocksource_init() function initializes the 32K
> timer as the system clock source regardless of the CONFIG_OMAP_32K_TIMER
> setting.
> Fix this by providing a default implementation for
> !CONFIG_OMAP_32K_TIMER case.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
