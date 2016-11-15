From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Nov 2016 16:12:35 +0000
Subject: [PATCH 0/3] arm64: dts: hisi: hip06 SAS device tree fixes
In-Reply-To: <1478537065-169286-1-git-send-email-john.garry@huawei.com>
References: <1478537065-169286-1-git-send-email-john.garry@huawei.com>
Message-ID: <582B33F3.2040700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 2016/11/7 16:44, John Garry wrote:
> This patchset resolves some hip06 SAS device tree issues.
>

Series applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

> John Garry (3):
>   arm64: dts: hisi: fix hip06 sas am-max-trans quirk
>   arm64: dts: hisi: disable sas0 and sas2 for d03
>   arm64: dts: hisi: add refclk node to hip06 dts files for SAS
> 
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 --------
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 11 ++++++++++-
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
