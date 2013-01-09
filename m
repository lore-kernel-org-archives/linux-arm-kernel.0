From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 21:22:07 +0000
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <201301092122.08011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Thierry Reding wrote:
> Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> directory. The motivation is to collect various host controller drivers
> in the same location in order to facilitate refactoring.
> 
> The Tegra PCIe driver has been largely rewritten, both in order to turn
> it into a proper platform driver and to add MSI (based on code by
> Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Can you split this patch into two patches, one that moves the file,
and another one that does all the changes? It's a little hard to
review when I can't easily see which code is actually new here.

	Arnd
