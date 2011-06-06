From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Mon, 6 Jun 2011 17:35:57 +0200
Subject: [RFC 0/6] iommu: generic api migration and grouping
In-Reply-To: <BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<20110606100950.GC30762@amd.com>
	<BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
Message-ID: <20110606153557.GE1953@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 11:15:30AM -0400, Ohad Ben-Cohen wrote:

> This is insufficient; users need somehow to tell what page sizes are
> supported by the underlying hardware (we can't assume host page-sizes,
> and we want to use bigger pages whenever possible, to relax the TLB
> pressure).
/
What does the IOMMU-API user need this info for? On the x86 IOMMUs these
details are handled transparently by the IOMMU driver.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
