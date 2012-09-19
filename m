From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 19 Sep 2012 02:00:54 +0200
Subject: [PATCH 7/8] mfd: Use the AB8500's IRQ domain to convert hwirq to
 virq
In-Reply-To: <1344527635-6163-8-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20120919000054.GZ3647@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, Aug 09, 2012 at 04:53:54PM +0100, Lee Jones wrote:
> Before the AB8500 had its own IRQ domain, the IRQ handler would take
> the fired local IRQ (hwirq) and add it to the irq_base to convert it
> to an IRQ number which Linux would understand (virq). However, the
> IRQ base is not always used anymore since we can make use of Linear
> domains. It's better to use the AB8500 hwirq -> virq mapping helper
> function to convert them instead. That's what we do here.
> 
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
Patch applied now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
