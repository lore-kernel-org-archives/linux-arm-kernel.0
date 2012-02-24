From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 24 Feb 2012 11:50:54 +0530
Subject: [PATCH 1/5] ARM: OMAP2+: l3_noc: Remove references to static IRQ
 defines
In-Reply-To: <1330035801-14937-2-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
 <1330035801-14937-2-git-send-email-b-cousson@ti.com>
Message-ID: <CAMQu2gxUYoy1p=PMN3XJqTM839gonYEGDC+YpyseHk9BwPDENA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> The irq numbers are retrieved dynamically but the error logging
> is still referring to the OMAP44XX_IRQ_XXX defines instead of the
> irq number returned by platform_get_irq.
>
> Remove this reference to allow deletion of the irqs-44xx.h files.
> Clean the message and replace the pr_ macro by the dev_ equivalent.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Thanks Benoit. Patch looks good to me
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
