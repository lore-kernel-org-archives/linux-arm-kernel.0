From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 10 Jan 2015 12:46:22 +0000
Subject: [PATCH v2 07/21] genirq: Add =?UTF-8?Q?irqchip=5Fset=5Fwake?=
 =?UTF-8?Q?=5Fparent?=
In-Reply-To: <20150108151500.GA24705@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-8-git-send-email-marc.zyngier@arm.com>
 <20150108151500.GA24705@kahuna>
Message-ID: <dd81cd2b499ca6cc595010ebe80d8f89@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-01-08 15:15, Nishanth Menon wrote:
> On 17:42-20150107, Marc Zyngier wrote:
>> This proves to be usefull with stacked domains, when the current
> 			^^ useful ?
> minor:
> +WARNING: 'usefull' may be misspelled - perhaps 'useful'?
> +#6:
> +This proves to be usefull with stacked domains, when the current
> +CHECK: extern prototypes should be avoided in .h files
> +#23: FILE: include/linux/irq.h:463:
> ++extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned
> int on);

Consistency trumps whatever checkpatch says, I'm afraid.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
