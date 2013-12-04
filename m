From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 4 Dec 2013 22:25:30 +0100 (CET)
Subject: [PATCH V7 1/2] genirq: Add an accessor for IRQ_PER_CPU flag
In-Reply-To: <1386151791-4881-2-git-send-email-vkale@apm.com>
References: <1386151791-4881-1-git-send-email-vkale@apm.com>
 <1386151791-4881-2-git-send-email-vkale@apm.com>
Message-ID: <alpine.DEB.2.02.1312042223310.30673@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Dec 2013, Vinayak Kale wrote:

> This patch adds an accessor function for IRQ_PER_CPU flag.
> The accessor function is useful to determine whether an IRQ is percpu or not.
> 
> This patch is based on an older patch posted by Chris Smith here [1].
> There is a minor change w.r.t. Chris's original patch: The accessor function
> is renamed as 'irq_is_percpu' instead of 'irq_is_per_cpu'.
> 
> [1]: http://lkml.indiana.edu/hypermail/linux/kernel/1207.3/02955.html
> 
> Signed-off-by: Chris Smith <chris.smith@st.com>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

For the genirq part:
    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Please take that through the SoC tree which carries the actual user of
this.

Thanks,

	tglx
