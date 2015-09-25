From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 25 Sep 2015 07:51:43 -0500
Subject: [PATCH 0/6] mvebu PCI fixes and cleanups
In-Reply-To: <20150925093858.0af99c28@free-electrons.com>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <20150925093858.0af99c28@free-electrons.com>
Message-ID: <20150925125143.GA25688@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 09:38:58AM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> On Wed, 23 Sep 2015 18:17:07 +0100, Russell King - ARM Linux wrote:
> > This small series contains a number of fixes and cleanups to the
> > mvebu PCI host code.
> 
> I've tested this series on my Armada XP GP board, with 3 PCIe cards
> connected (one Intel e1000e NIC, one generic AHCI SATA card, and one
> Marvell SATA card), and I saw no obvious regressions. The PCIe devices
> are still properly enumerated, and they seem to work fine. There is no
> change in the 'lspci -vv' output.
> 
> Moreover, I've reviewed the different patches, and they look alright to
> me.
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Bjorn, will you propagate the Tested-by/Reviewed-by to all patches on
> the series, or since I believe you're using patchwork, you want us to
> post Tested-by/Reviewed-by replies to each patch?

I'll propagate them, thanks.  I use patchwork, but really only as a
to-do list.  I actually apply patches from mutt and tweak them using
stgit.

Bjorn
