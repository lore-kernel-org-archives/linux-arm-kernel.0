From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jul 2015 00:01:40 -0700
Subject: [PATCH 0/2] Add missing #iommu-cells on IOMMU nodes
In-Reply-To: <1436549336-33456-1-git-send-email-s-anna@ti.com>
References: <1436549336-33456-1-git-send-email-s-anna@ti.com>
Message-ID: <20150714070140.GF17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [150710 10:31]:
> Hi Tony,
> 
> This series adds the #iommu-cells property to the existing
> IOMMU nodes on OMAP4 & OMAP5. It was already fixed for OMAP3
> in commit 2055088b5e17 ("ARM: dts: omap3: Add #iommu-cells to
> isp and iva iommu").
> 
> OMAP4 and OMAP5 do not yet have users for these IOMMUs (remoteproc
> nodes), so the warning as seen with the fix added for OMAP3 is not
> seen yet, but will as soon as a user is added.

Applying both into omap-for-v4.2/fixes thanks.

Tony
