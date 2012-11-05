From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 5 Nov 2012 23:59:22 +0100
Subject: [PATCH 6/8] mfd/ab8500-core: use irq_domain_add_simple()
In-Reply-To: <1350580755-8516-1-git-send-email-linus.walleij@stericsson.com>
References: <1350580755-8516-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121105225922.GF7965@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Oct 18, 2012 at 07:19:15PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> To be able to use SPARSE_IRQ while yet not using device tree,
> we need to use irq_domain_add_simple() that will allocate
> descriptors for the IRQs in the non-DT case, and fall back
> to using the linear irqdomain in the DT case.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
In case it's not too late:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
