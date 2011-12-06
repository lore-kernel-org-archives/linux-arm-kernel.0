From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 6 Dec 2011 13:57:39 +0100
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <CAHQjnOOCHO3eDiUft4WgS=8N5EheWas+n3MD9xxBKUoSjmNQSQ@mail.gmail.com>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
 <20111205154715.GE25178@amd.com>
 <CAH9JG2VALcm-PreS7S2SZPPgEbid_6_VWJA0PHBEtY5KvaA3Og@mail.gmail.com>
 <CAHQjnOOCHO3eDiUft4WgS=8N5EheWas+n3MD9xxBKUoSjmNQSQ@mail.gmail.com>
Message-ID: <20111206125739.GK25178@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 09:13:18PM +0900, KyongHo Cho wrote:
> > BTW, how do you test it at mainline kernel?
> >
> I merged IOMMU mainline branch to our kernel branch and tested it with
> our FIMC, MFC, JPEG, 2D.

This is not sufficient. Please do it the other way around, merge your
outstanding changes into the mainline kernel (or for iommu topics my
next branch) and test against that. This way it is easier to catch bugs
in mainline.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
