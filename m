From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 13 Jun 2011 13:24:10 +0900
Subject: [PATCH] PCI: Make the struct pci_dev * argument of pci_fixup_irqs
	const.
In-Reply-To: <20110610143021.GA26043@linux-mips.org>
References: <20110610143021.GA26043@linux-mips.org>
Message-ID: <20110613042410.GB29731@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 03:30:21PM +0100, Ralf Baechle wrote:
> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
> 
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Paul Mundt <lethal@linux-sh.org>
