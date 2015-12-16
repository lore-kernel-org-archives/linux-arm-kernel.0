From: prem.mallappa@broadcom.com (Prem (Premachandra) Mallappa)
Date: Wed, 16 Dec 2015 10:49:07 +0000
Subject: [PATCH] IOMMU: arm-smmu-v3: fix broken S2PS and AARCH64 in
 Broadcom Vulcan
In-Reply-To: <20151216101735.GB4308@arm.com>
References: <1450110687-32207-1-git-send-email-pmallapp@broadcom.com>
 <20151215134010.GH9452@arm.com>
 <CC0BC9CB4553B146B290EC1D4DC5C35901094BCE@SJEXCHMB15.corp.ad.broadcom.com>
 <20151216101735.GB4308@arm.com>
Message-ID: <CC0BC9CB4553B146B290EC1D4DC5C35901094C41@SJEXCHMB15.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Ok -- so what is the value reported by your IDR5?

Our  IDR5, OAS=0x4 (44bits) 

> 
> Ok, I just didn't see any mention of that in the commit message and wanted
> to make sure it wasn't an accidental unrelated change.
> 
Got it.

/Prem
