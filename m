From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 Jun 2016 16:10:23 +0200
Subject: [PATCH v2 1/3] dt-bindings: add DT binding for the Aardvark
 PCIe controller
In-Reply-To: <20160622161656.GE25485@localhost>
References: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1465574056-8787-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160622161656.GE25485@localhost>
Message-ID: <20160623161023.14017043@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 22 Jun 2016 11:16:56 -0500, Bjorn Helgaas wrote:

> > + - compatible: Should be "marvell,armada-3700-pcie"
> > + - reg: range of registers for the PCIe controller
> > + - interrupts: the interrupt line of the PCIe controller
> > + - #address-cells: set to <3>
> > + - #size-cells: set to <2>
> > + - device_type: set to "pci"
> > + - ranges: ranges for the PCI memory and I/O regions
> > + - #interrupt-cells: set to <1>
> > + - msi-controller: indicates that the PCIe controller can itself
> > +   handled MSI interrupts  
> 
> s/handled/handle/

Thanks. Fixed for v3!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
