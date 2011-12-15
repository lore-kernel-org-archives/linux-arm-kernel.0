From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 13:25:20 +0800
Subject: [PATCH 3/9] irq: convert generic-chip to use irq_domain
In-Reply-To: <1323876538-20406-4-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-4-git-send-email-robherring2@gmail.com>
Message-ID: <20111215052512.GB21815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:28:52AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add irq domain support to irq generic-chip. This enables users of
> generic-chip to support dynamic irq assignment needed for DT interrupt
> binding. Users must be converted to use irq_data.hwirq for determining
> local interrupt numbers rather than using the Linux irq number.
> 
> irq_base is kept for now as there are a few users of it. Once they
> are converted to use the irq domain, it can be removed.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
