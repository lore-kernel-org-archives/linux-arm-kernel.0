From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 14 Jun 2011 12:29:16 +0200
Subject: [PATCH v2 0/4] drivers/iommu/ relocations
In-Reply-To: <1307742947-32118-1-git-send-email-ohad@wizery.com>
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
Message-ID: <20110614102916.GF29908@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 05:55:43PM -0400, Ohad Ben-Cohen wrote:
> Ohad Ben-Cohen (4):
>   drivers: iommu: move to a dedicated folder
>   msm: iommu: move to drivers/iommu/
>   x86: amd_iommu: move to drivers/iommu/
>   x86/ia64: intel-iommu: move to drivers/iommu/

Btw, what tree do these patches apply against? I tried to apply them to
v3.0-rc3 and got conflicts. Can you rebase them against -rc3?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
