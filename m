From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 05 Apr 2013 15:49:53 +0900
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
In-Reply-To: <20130405160256.7ca6f52e25e0d2231eb1fcfe@canb.auug.org.au>
References: <20130405160256.7ca6f52e25e0d2231eb1fcfe@canb.auug.org.au>
Message-ID: <2a5a01ce31c9$c7051670$550f4350$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell wrote:
> 
> Hi Kukjin,
> 
Hi,

> Today's linux-next merge of the samsung tree got a conflict in
> drivers/irqchip/irq-s3c24xx.c between commit de88cbb7b244 ("arm: Move
> chained_irq_(enter|exit) to a generic file") from the arm-soc tree (where
> it is called arch/arm/mach-s3c24xx/irq.c) and commit f0774d41da0e
> ("irqchip: s3c24xx: add devicetree support") from the samsung tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 
Looks good to me, thanks.

- Kukjin
