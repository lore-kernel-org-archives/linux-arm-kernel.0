From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Jan 2015 09:15:01 -0600
Subject: [PATCH v2 07/21] genirq: Add irqchip_set_wake_parent
In-Reply-To: <1420652576-22309-8-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108151500.GA24705@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:42-20150107, Marc Zyngier wrote:
> This proves to be usefull with stacked domains, when the current
			^^ useful ?
minor:
+WARNING: 'usefull' may be misspelled - perhaps 'useful'?
+#6: 
+This proves to be usefull with stacked domains, when the current
+CHECK: extern prototypes should be avoided in .h files
+#23: FILE: include/linux/irq.h:463:
++extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);

-- 
Regards,
Nishanth Menon
