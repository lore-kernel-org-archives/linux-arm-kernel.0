From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 12 Nov 2009 18:26:06 +0100
Subject: PCI hotplug supported on ARM (Kirkwood)?
Message-ID: <200911121826.06792.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

is it possible to boot a FPGA which is connected to an PCI bus on a kirkwood cpu (via a pcie->pci bridge)
at runtime (I call it hotplug)?

And after booting the FPGA e.g. via slave serial protocol loading the pci driver and access the device?
This would be much easier to handle than flashing the fpga using u-boot.

Is there any special framework I have to use? How can I tell the kernel to reenumerate the bus and reasign
the pci resources?

I have googled a lot and also tried to find something at newsgroups or mailinglists but I haven't found some
valuable information - at least not for me ;).
Is this possible?

Many thanks,
Dieter
