From: b08248@gmail.com (Stuart Yoder)
Date: Thu, 4 Dec 2014 15:52:08 -0600
Subject: [PATCH v3 09/13] irqchip: GICv3: ITS: MSI support
In-Reply-To: <1416839720-18400-10-git-send-email-marc.zyngier@arm.com>
References: <1416839720-18400-1-git-send-email-marc.zyngier@arm.com>
 <1416839720-18400-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <CALRxmdAULDXqx5oNUGQx9y2oUegULKO7=gWQWMRkFOzFo9XS8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 8:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> +/*
> + * We need a value to serve as a irq-type for LPIs. Choose one that will
> + * hopefully pique the interest of the reviewer.
> + */
> +#define GIC_IRQ_TYPE_LPI               0xa110c8ed

Ok, my interest is piqued.  Why this value?

Stuart
