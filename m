From: davem@davemloft.net (David Miller)
Date: Sat, 11 Jun 2011 16:01:19 -0700 (PDT)
Subject: [PATCH] PCI: Make the struct pci_dev * argument of
	pci_fixup_irqs const.
In-Reply-To: <20110610143021.GA26043@linux-mips.org>
References: <20110610143021.GA26043@linux-mips.org>
Message-ID: <20110611.160119.176399204911265689.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 10 Jun 2011 15:30:21 +0100

> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
> 
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: David S. Miller <davem@davemloft.net>
