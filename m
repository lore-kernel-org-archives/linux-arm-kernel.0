From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Fri, 21 Jun 2013 14:12:02 +0000
Subject: [PATCH v2 1/3] mfd: Add irq domain support for max8998 interrupts
In-Reply-To: <1371818017-5215-2-git-send-email-t.figa@samsung.com> (Tomasz
 Figa's message of "Fri, 21 Jun 2013 14:33:35 +0200")
References: <1371818017-5215-1-git-send-email-t.figa@samsung.com>
 <1371818017-5215-2-git-send-email-t.figa@samsung.com>
Message-ID: <u0l61x7a6z1.fsf@orc04.imf.au.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa <t.figa@samsung.com> writes:

> All uses of irq_base in platform data and max8997 driver private data
> are removed.
>
[...]
> +static int max8998_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +					irq_hw_number_t hw)
> +{
> +	struct max8997_dev *max8998 = d->host_data;

I may be wrong, but this sure looks like a typo (or copy-pasto).

-- 
Rasmus Villemoes
<http://rasmusvillemoes.dk/>
