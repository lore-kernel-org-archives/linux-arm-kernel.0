From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Fri, 17 Jun 2011 15:18:36 +0200
Subject: [PATCH v2 4/4] x86/ia64: intel-iommu: move to drivers/iommu/
In-Reply-To: <1307742947-32118-5-git-send-email-ohad@wizery.com>
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
	<1307742947-32118-5-git-send-email-ohad@wizery.com>
Message-ID: <20110617131836.GE6689@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 05:55:47PM -0400, Ohad Ben-Cohen wrote:
> This should ease finding similarities with different platforms,
> with the intention of solving problems once in a generic framework
> which everyone can use.
> 
> Note: to move intel-iommu.c, the declaration of pci_find_upstream_pcie_bridge()
> has to move from drivers/pci/pci.h to include/linux/pci.h. This is handled
> in this patch, too.

David, does this look good to you? Can you send an ACK if so?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
