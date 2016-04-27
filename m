From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 27 Apr 2016 16:12:52 +0100
Subject: [PATCH v2 0/2] arm64: hisilicon: hip05 fix and update
In-Reply-To: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <5720D6F4.2000401@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 08/04/2016 08:31, Kefeng Wang wrote:
> Hip05:
> - Fix its node without msi-cells
> - Add nor flash node
> 
> Change since v1:
> - msi-cells should be #msi-cells
> 
> Kefeng Wang (2):
>   arm64: dts: hip05: fix its node without msi-cells
>   arm64: dts: hip05: Add nor flash support
> 
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 34 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 10 +++++++++
>  2 files changed, 44 insertions(+)
> 

Thanks!
Applied both to the hisilicon soc tree.

Best Regards,
Wei
