From: florian@openwrt.org (Florian Fainelli)
Date: Sat, 02 Jun 2012 16:18:11 +0200
Subject: ARM PCI controller registration and representation using device tree?
Message-ID: <4113992.BTnO0ZYQON@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was wondering if anyone had started working on representing the various PCI 
controllers found on SoCs to a device tree representation?

It seems like quite some generic code could be borrowed from PowerPC, 
especially the parsing of the PCI ranges, though I don't see ARM directly 
exposing a struct pci_controller to easily allow that.

Any thoughts about this?

Thanks.
-- 
Florian
