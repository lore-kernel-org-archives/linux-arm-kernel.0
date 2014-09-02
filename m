From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 2 Sep 2014 11:58:46 -0600
Subject: SPEAr PCIe driver build failures in ARM allmodconfig
In-Reply-To: <20140901232208.GN29327@sirena.org.uk>
References: <E1XOXLn-0004fl-2V@cassiel.sirena.org.uk>
 <20140901232208.GN29327@sirena.org.uk>
Message-ID: <CAErSpo76Jz+jH6Znwuq5F-SW2pv+LNbqUiwpjc7w1b5rccWf1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 1, 2014 at 5:22 PM, Mark Brown <broonie@kernel.org> wrote:
> ARM allmodconfig has started failing to build in Linus' tree in the past
> few days with undefined dependencies in the SPEAr PCIe driver:
>
>>       arm-allmodconfig
>> ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>> ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>> ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>> ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>> ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>> ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>> ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>
> This has been fixed in -next with commit 8d7004a6904cf0 (PCI: spear:
> Remove module option), can that be sent to Linus too please?

Done, thanks for the reminder.
