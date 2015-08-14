From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 14 Aug 2015 09:53:10 -0500
Subject: [PATCH v3 0/5] PCI: st: provide support for dw pcie
In-Reply-To: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150814145310.GD26431@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:12:43AM +0200, Gabriel FERNANDEZ wrote:
> Changes in v3:
>  - Remove power management functions (was not fully tested)
>  - Remove configuration space range from dt binding
>  - Remove pci_common_init_dev() call in pcie-designware.c to avoid 
>    default IO space declaration. 
> 
> Changes in v2:
>  - comestic corrections in device tree binding
>  - add pci-st.c into MAINTAINERS
>  - remove st_pcie_ops structure to avoid another level of indirection
>  - remove nasty busy-loop
>  - remove useless test using virt_to_phys()
>  - move disable io support into dw-pcie driver
> 
> I don't change the st_pcie_abort_handler() function because abort handling
> is masked during boot.
> 
> 
> This patch-set introduces a STMicroelectronics PCIe controller.
> It's based on designware PCIe driver.
> 
> Gabriel Fernandez (5):
>   ARM: STi: Kconfig update for PCIe support
>   PCI: st: Add Device Tree bindings for sti pcie
>   PCI: st: Provide support for the sti PCIe controller
>   pci: designware: remove pci_common_init_dev()
>   MAINTAINERS: Add pci-st.c to ARCH/STI architecture

Hi Gabriel,

I lost track of where we are with this.  I *think* I'm waiting for a v4
posting, but I haven't seen it yet.  Let me know if I've missed something.

Bjorn
