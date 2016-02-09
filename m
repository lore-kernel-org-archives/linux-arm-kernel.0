From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 15:41:54 +0100
Subject: [PATCH V3 0/5] PCIe Xilinx generic driver for Microblaze and
In-Reply-To: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
References: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
Message-ID: <20578581.RaDqZvvMdm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 16:11:53 Bharat Kumar Gogada wrote:
> This patch series does modifications to pcie-xilinx.c, to support common
> driver on both Zynq and Microblaze architectures.
> Microblaze pci-common.c has been modified to support generic driver.
> 
> Bharat Kumar Gogada (5):
>   PCI: xilinx: Removing xilinx_pcie_parse_and_add_res function
>   PCI: xilinx: Removing struct hw_pci structure.
>   PCI: xilinx: Modifying AXI PCIe Host Bridge driver to     work on both
>      Zynq and Microblaze
>   PCI: xilinx: Updating Zynq PCI binding documentation     with 
>     Microblaze node.
>   Microblaze: Modifying microblaze PCI subsytem to     support  generic
>     Xilinx  AXI PCIe Host Bridge IP driver
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I'm still not happy about needing the pci_fixup_irqs in patch 3/5, but
I can understand that fixing this is beyond the scope of your series.

	Arnd
