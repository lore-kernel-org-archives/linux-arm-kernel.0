From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 May 2018 15:50:54 +0100
Subject: [PATCH v2 0/5] Hi3660: enable power management features
In-Reply-To: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
References: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
Message-ID: <5AFAF3CE.70601@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 2018/5/15 3:53, Leo Yan wrote:
> Since hi3660 drivers have been merged into Linux kernel (mailbox driver is in
> Linux-next branch and other drivers are existed in Linux mainline kernel), so
> this patch series is to enable power management features on hi3660.
> 
> This patch series includes device tree binding for mailbox, stub clock and CPU
> OPPs, and has one patch to consolidate the Kconfigs for driver modules.
> 
> This patch set have been tested on Hikey960 and also verified the patch 'hisi:
> Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX' for Hikey620.
> 
> Changes from v1:
> * Changed patch subject from "dts: arm64: hi3660" to "arm64: dts: hi3660".
> 
> 
> Daniel Lezcano (1):
>   hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX
> 
> Kaihua Zhong (2):
>   arm64: dts: hi3660: Add mailbox node
>   arm64: dts: hi3660: Add stub clock node
> 
> Leo Yan (1):
>   arm64: dts: hi3660: Add CPU frequency scaling support
> 
> Tao Wang (1):
>   arm64: dts: hi3660: Add thermal cooling management
> 
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 145 ++++++++++++++++++++++++++++++
>  arch/arm64/configs/defconfig              |   1 -
>  drivers/clk/hisilicon/Kconfig             |  13 +--
>  drivers/mailbox/Kconfig                   |  12 ++-
>  4 files changed, 161 insertions(+), 10 deletions(-)
> 

Applied patch 1 to 4.
Thanks!

Best Regards,
Wei
