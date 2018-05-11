From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 11 May 2018 15:00:28 +0100
Subject: [PATCH 0/3] HiSilicon LPC defconfig and DT patches
In-Reply-To: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
References: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
Message-ID: <5AF5A1FC.5000900@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 2018/4/30 16:15, John Garry wrote:
> This series introduces 3 patches, to enable the
> HISILICON_LPC config in the arm64 defconfig
> and also add the relevant LPC DT entries.
> 
> For hip06 UART support, we depend on this patch:
> https://lkml.org/lkml/2018/4/27/258
> 
> John Garry (3):
>   arm64: defconfig: Enable HISILICON_LPC
>   arm64: dts: hisi: Enable Hisi LPC node for hip06
>   arm64: dts: hisi: Enable Hisi LPC node for hip07
> 
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 ++++++++
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 21 +++++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts |  4 ++++
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi    | 14 ++++++++++++++
>  arch/arm64/configs/defconfig                |  1 +
>  5 files changed, 48 insertions(+)
> 

Series applied into the hisilicon tree.
Thanks!

BR,
Wei
