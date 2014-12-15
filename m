From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Dec 2014 22:30:06 +0100
Subject: [PATCH 3/3] Documentation: dt-bindings: Add the binding info for
 APM X-Gene AHBC IOMMU driver.
In-Reply-To: <1418662523-8458-4-git-send-email-stripathi@apm.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
 <1418662523-8458-4-git-send-email-stripathi@apm.com>
Message-ID: <17322841.g8pTBk7ToU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 22:25:23 Suman Tripathi wrote:
> +*APM X-Gene AHBC IOMMU Architecture Implementation
> +
> +APM X-Gene SoC AHBC IOMMU translates the AHBC 32-bit address from
> +dma master to 42-bit AXI address by using a set of AIM(AHB Inbound mapper)
> +register.
> +
> +** AHBC IOMMU required properties:
> +
> +- compatible    : Should be "apm,xgene-ahbc-iommu"
> +- reg           : Base address of the AHBC AXI mapper registers
> +
> +Example:
> +
> +               ahbc_iommu: ahbc_iommu at 0x1f2a0080 {
> +                       compatible = "apm,xgene-ahbc-iommu";
> +                       reg = <0x0 0x1f2a0080 0x0 0x90>;
> +               };
> --
> 1.8.2.1
> 

This is incompatible with the iommu binding from 
Documentation/devicetree/bindings/iommu/iommu.txt

Please fix.

	Arnd
