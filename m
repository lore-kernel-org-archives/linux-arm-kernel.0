From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 3 Apr 2014 16:07:13 -0600
Subject: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
In-Reply-To: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140403220713.GA23545@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:53:01PM +0000, Will Deacon wrote:
> Hello,
> 
> This small set of patches brings PCI support to mach-virt based upon an
> idealised host controller (see patch 2 for more details).
> 
> This has been tested with kvmtool, for which I have a corresponding set
> of patches which you can find in my kvmtool/pci branch at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
> 
> Once the arm64 PCI patches from Liviu have stabilised, I plan to port
> this host controller to work there as well.
> 
> The main issue I can see with this code is how to describe configuration
> space in the device-tree. I'm following the ePAPR PCI bindings (SS == 0)
> , but this adds an ugly 'case 0:' line in the pci range parser, which
> also exists in mainline for the pcie-designware.c driver.

There was a long discussion about this (especially 2/3), and I didn't
follow it closely enough to get the resolution, and I don't think I
picked up the patches.

Can you post them again if they're still applicable?

Thanks,
  Bjorn
