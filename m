From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 14 Dec 2011 22:45:31 +0000
Subject: [PATCH 1/2] irqdomain: export irq_domain_simple_ops for !CONFIG_OF
In-Reply-To: <1323902398-10072-1-git-send-email-jamie@jamieiles.com>
References: <1323902398-10072-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111214224531.GB3125@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 10:39:57PM +0000, Jamie Iles wrote:
> irqdomain support is used in interrupt controller drivers that may not
> have device tree support but only need the basic HW->Linux irq
> translation.  Rather than having each of these implement their own IRQ
> domain, allow them to use the simple ops.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

I've put these in the patch tracker as 723[56]/1 for expediency.

Jamie
