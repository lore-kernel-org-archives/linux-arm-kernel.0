From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 Jun 2016 19:33:30 +0200
Subject: [PATCH v2 2/3] PCI: host: new PCI host controller driver for
 Aardvark
In-Reply-To: <20160622161607.GD25485@localhost>
References: <1465574056-8787-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <201606111501.h2bC6u5a%fengguang.wu@intel.com>
 <20160622161607.GD25485@localhost>
Message-ID: <20160622193330.490d1bce@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 22 Jun 2016 11:16:07 -0500, Bjorn Helgaas wrote:

> > All errors (new ones prefixed by >>):
> >   
> > >> drivers/of/Kconfig:4:error: recursive dependency detected!  
> 
> Was there a resolution to this?

Yes, Arnd sent a patch which I believe addresses this:

	[PATCH] arm/arm64/irqchip/pci: fix PCI_MSI dependencies

I'll verify locally that it indeed solves the problem.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
