From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 25 Feb 2016 09:59:11 -0600
Subject: [PATCH v3 0/6] Xilinx AXI PCIe Host Bridge driver fixes
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <20160225155911.GF8120@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Feb 04, 2016 at 04:10:07PM +0000, Paul Burton wrote:
> This series fixes a number of issues found using the Xilinx AXI PCIe
> Host Bridge IP on the Imagination Technologies MIPS Boston development
> board. It has been split out of the larger Boston board support series
> at Michal's request.
> 
> Applies atop v4.5-rc2.
> 
> Paul Burton (6):
>   PCI: xilinx: Keep references to both IRQ domains
>   PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
>   PCI: xilinx: Always clear interrupt decode register
>   PCI: xilinx: Clear interrupt FIFO during probe
>   PCI: xilinx: Fix INTX irq dispatch
>   PCI: xilinx: Allow build on MIPS platforms
> 
>  drivers/pci/host/Kconfig       |   2 +-
>  drivers/pci/host/pcie-xilinx.c | 125 +++++++++++++++++++----------------------

Looks like Bharat has some IRQ concerns, so I'm guessing you'll be
posting a v4?

Bjorn
