From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Aug 2013 15:31:48 +0200
Subject: linux-next: manual merge of the mvebu tree with the pci tree
In-Reply-To: <20130814161840.dcee2b1354579cce7ff81730@canb.auug.org.au>
References: <20130814161840.dcee2b1354579cce7ff81730@canb.auug.org.au>
Message-ID: <20130815153148.579ad2e5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Rothwell,

On Wed, 14 Aug 2013 16:18:40 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mvebu tree got a conflict in
> drivers/pci/host/Kconfig between commit 5477a33b51b7 ("PCI: mvebu: Make
> Marvell PCIe driver depend on OF") from the pci tree and commit
> 31d896ade95d ("PCI: mvebu: add support for Marvell Dove SoCs") from the
> mvebu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Your fix seems correct to me.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
