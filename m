From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 21:08:50 +0200
Subject: [PATCH v3 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
In-Reply-To: <20160426173144.GB27803@localhost>
References: <1461659506-10387-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160426173144.GB27803@localhost>
Message-ID: <20160426210850.13cc8a0e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 26 Apr 2016 12:31:44 -0500, Bjorn Helgaas wrote:

> >  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
> >  create mode 100644 drivers/pci/host/pcie-armada8k.c
> 
> Thanks, Thomas, I applied these to pci/host-armada for v4.7.

Thanks!

> I added the tweaks below to use dev_dbg() instead of pr_debug(), use
> dw_pcie_wait_for_link() instead of another hand-coded timeout loop,
> and fix a typo and remove unused constants.

Looks all good, thanks for applying! Just one tiny question below.

>  	/*
>  	 * Interrupts are directly handled by the device driver of the
> -	 * PCI device. However, there are also latched into the PCIe
> +	 * PCI device.  However, they are also latched into the PCIe

Any reason to have two spaces after the dot here?

Thanks again!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
