From: ddutile@redhat.com (Don Dutile)
Date: Mon, 15 Dec 2014 14:38:12 -0500
Subject: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
In-Reply-To: <1418662523-8458-1-git-send-email-stripathi@apm.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
Message-ID: <548F38A4.5090703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You should be cc-ing Mark Langsdorf, not myself, for Xgene kernel support.

also note: I'm already on the IOMMU mailing list, so I'll see such patches via
that list.

- Don

On 12/15/2014 11:55 AM, Suman Tripathi wrote:
> This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>
> Suman Tripathi (3):
>    xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU driver.
>    arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
>    Documentation: dt-bindings: Add the binding info for APM X-Gene AHBC
>      IOMMU driver.
>
>   .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |  17 ++
>   arch/arm64/boot/dts/apm-storm.dtsi                 |   5 +
>   drivers/iommu/Kconfig                              |  10 +
>   drivers/iommu/Makefile                             |   1 +
>   drivers/iommu/xgene-ahbc-iommu.c                   | 336 +++++++++++++++++++++
>   5 files changed, 369 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
>   create mode 100644 drivers/iommu/xgene-ahbc-iommu.c
>
> --
> 1.8.2.1
>
