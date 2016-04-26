From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 13:13:04 +0200
Subject: [GIT PULL] Renesas ARM Based SoC PCI Defconfig Updates for v4.7
In-Reply-To: <cover.1461631445.git.horms+renesas@verge.net.au>
References: <cover.1461631445.git.horms+renesas@verge.net.au>
Message-ID: <4949462.nM0EuO7OEc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 10:50:10 Simon Horman wrote:
> Please consider these Renesas ARM based SoC PCI defconfig updates for v4.7.
> 
> 
> This pull request includes a single patch with changes that I would
> ordinarily be inclined to split into different branches. However,
> are most easily done atomicly and as they are rather small I have
> kept them in one patch in its own branch. My hope is that you can find
> an appropriate home for it.
> 
> The patch updates renames PCI_RCAR_GEN2_PCIE Kconfig symbol
> as PCIE_RCAR. It includes PCI Makefile and Kconfig changes and
> accordingly the patch has an ack from Bjorn Helgaas. It also updates
> arm and arm64 defconfigs.
> 

I've merged it into next/defconfig and made sure we don't (yet) have
any conflicts against changes in the arm64 defconfig. Thanks,

	Arnd
