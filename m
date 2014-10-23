From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 24 Oct 2014 00:15:44 +0800
Subject: [PATCH 0/3] Rockchip IOMMU driver and devicetree bindings
In-Reply-To: <20141022152019.GK10074@8bytes.org>
References: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
 <20141022152019.GK10074@8bytes.org>
Message-ID: <CAGS+omDyKLVqmvVtJBez7SuC_oqkpov1e-ikfLE=NBcY0Mx45A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 11:20 PM, Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Oct 01, 2014 at 06:20:40PM +0800, Daniel Kurtz wrote:
>> Add a driver and devicetree bindings for the IOMMU found in Rockchip RK3288
>> SoCs.
>>
>> Daniel Kurtz (3):
>>   iommu/rockchip: rk3288 iommu driver
>>   dt-bindings: iommu: Add documentation for rockchip iommu
>>   ARM: dts: rk3288: add VOP iommu nodes
>>
>>  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  26 +
>>  arch/arm/boot/dts/rk3288.dtsi                      |  18 +
>>  drivers/iommu/Kconfig                              |  11 +
>>  drivers/iommu/Makefile                             |   1 +
>>  drivers/iommu/rockchip-iommu.c                     | 924 +++++++++++++++++++++
>>  5 files changed, 980 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>  create mode 100644 drivers/iommu/rockchip-iommu.c
>
> Please make sure you also get Acks for the DT bindings. With that and
> the issue I mentioned in the other email fixed, I will apply these
> patches?
>
>
>         Joerg

Hi Joerg,

Thanks for your reviews.
Can you help get these DT bindings Acked?
AFAICT, the DT maintainers are CC'ed on this patch, I'm not sure what
else to do.

Thanks,
-Daniel
