From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 15 Dec 2014 21:27:39 +0100
Subject: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
In-Reply-To: <CAOHikRB0eBnPnE+QWdmWunOMFHJOLDqU6o2ByBruQ3KC+1-XmA@mail.gmail.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
 <548F3C91.3030803@redhat.com>
 <CAOHikRB0eBnPnE+QWdmWunOMFHJOLDqU6o2ByBruQ3KC+1-XmA@mail.gmail.com>
Message-ID: <20141215202738.GG24292@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Tue, Dec 16, 2014 at 01:31:58AM +0530, Suman Tripathi wrote:
> On Dec 16, 2014 1:25 AM, "Don Dutile" <ddutile@redhat.com> wrote:
> 
>     On 12/15/2014 11:55 AM, Suman Tripathi wrote:
> 
>         This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.
> 
>         Signed-off-by: Suman Tripathi <stripathi@apm.com>
>         ---
> 
>         Suman Tripathi (3):
>         ? ?xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU driver.
>         ? ?arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
>         ? ?Documentation: dt-bindings: Add the binding info for APM X-Gene AHBC
>         ? ? ?IOMMU driver.
> 
>         ? .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |? 17 ++
>         ? arch/arm64/boot/dts/apm-storm.dtsi? ? ? ? ? ? ? ? ?|? ?5 +
>         ? drivers/iommu/Kconfig? ? ? ? ? ? ? ? ? ? ? ? ? ? ? |? 10 +
>         ? drivers/iommu/Makefile? ? ? ? ? ? ? ? ? ? ? ? ? ? ?|? ?1 +
>         ? drivers/iommu/xgene-ahbc-iommu.c? ? ? ? ? ? ? ? ? ?| 336
>         +++++++++++++++++++++
>         ? 5 files changed, 369 insertions(+)
>         ? create mode 100644 Documentation/devicetree/bindings/iommu/
>         xgene,ahbc-iommu.txt
>         ? create mode 100644 drivers/iommu/xgene-ahbc-iommu.c

What are the differences between the X-Gene IOMMU and the ARM-SMMU?


	Joerg
