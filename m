From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Aug 2016 16:12:12 +0100
Subject: [PATCH v3 0/5] arm64: hisilicon: Hip0x dt/config update
In-Reply-To: <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467170878-24030-1-git-send-email-wangkefeng.wang@huawei.com>
 <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <57BDB94C.4080908@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 15/08/2016 08:03, Kefeng Wang wrote:
> DT update:
> 1) Hip05
> - Kill unuesd hip05_hns.dtsi
> 2) Hip06
> - Add SAS/HNS node
> 
> CONFIG update:
> 1) Enable SAS/HNS config

Series applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

> 
> Changes since v2:
> - Update phy-count of sas2, it should be 9
> - Update mdio node according to commit b15dc29264d0(net: hns: get reset registers from DT)
> 
> Changes since v1:
> - Add dt binding document suggested by Wei xu and use better name.
> 
> 
> Kefeng Wang (5):
>   arm64: dts: hip05: kill hip05_hns.dtsi
>   dt-bindings: hisilicon: Add Hip05 and Hip06 system controller support
>   arm64: dts: hip06: Append hns node
>   arm64: dts: hip06: Append sas node
>   arm64: defconfig: Enable Hisi SAS and HNS
> 
>  .../bindings/arm/hisilicon/hisilicon.txt           |  39 ++-
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   5 -
>  arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi       | 180 ----------
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |  28 ++
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi           | 365 +++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   5 +-
>  6 files changed, 425 insertions(+), 197 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
> 
