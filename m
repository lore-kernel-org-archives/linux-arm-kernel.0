From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 19 Oct 2010 11:06:14 +0200
Subject: [PATCH v3] TWL IRQ: Fix fucntion declaration warnings
In-Reply-To: <1286315819-5906-4-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
	<1286315819-5906-4-git-send-email-manjugk@ti.com>
Message-ID: <20101019090613.GA2736@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

On Wed, Oct 06, 2010 at 03:26:59AM +0530, G, Manjunath Kondaiah wrote:
> Fixes following sparse warnings for twl4030 and twl6030 irq files.
> 
> drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_irq' was not declared. Should it be static?
> drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_irq' was not declared. Should it be static?
> drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_chip_irq' was not declared. Should it be static?
> 
> drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_irq' was not declared. Should it be static?
> drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_irq' was not declared. Should it be static?
>
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
