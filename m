From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 May 2013 15:25:18 +0200 (CEST)
Subject: [RFC patch 7/8] fixup 1/2: genirq: generic chip: Add linear irq
 domain support
In-Reply-To: <1367843533-7117-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130503214629.810207749@linutronix.de>
 <1367843533-7117-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <alpine.LFD.2.02.1305061524520.3095@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 May 2013, Sebastian Hesselbarth wrote:

> irq_domain_chip_generic is allocating and indexing irq_chip_generic
> itself. However, the size of irq_chip_generic varies with number of
> irq_chip_types. This fixup moves irq_chip_generic helt by
> irq_domain_chip_generic to array of ptr and fixes the pointer arith
> used by irq_alloc_domain_generic_chip.

Thanks. I folded it in.
