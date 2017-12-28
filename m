From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 28 Dec 2017 21:18:02 +0000
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.16
In-Reply-To: <5A3CD3EE.7030505@hisilicon.com>
References: <5A3CD3EE.7030505@hisilicon.com>
Message-ID: <5A455F8A.5010403@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

On 2017/12/22 9:44, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!

Sorry!
Please ignore this pull because the PSCI patch is still under discussion.
I will drop that patch and send v2.
Thanks!

Best Regards,
Wei

> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.16
> 
> for you to fetch changes up to 2b49083a2d93b1adb755f057ed569d1ae6a934c7:
> 
>   arm64: dts: Hi3660: Fix up psci state id (2017-12-22 09:11:43 +0000)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoC DT updates for 4.15
> 
> - Add SD card support for hi3798cv200-poplar board
> - Replace the PMU node with exact match on hi3660 SoC
> - Add cpu capacity-dmips-mhz information on hi3660 SoC
> - Fix up the PSCI state ID on hi3660 SoC
> 
> ----------------------------------------------------------------
> Leo Yan (1):
>       arm64: dts: Hi3660: Fix up psci state id
> 
> Shawn Guo (1):
>       arm64: dts: hi3798cv200: add SD card support
> 
> Valentin Schneider (1):
>       arm64: dts: hisilicon: Add hi3660 cpu capacity-dmips-mhz information
> 
> Xu YiPing (1):
>       arm64: dts: hi3660: improve pmu description
> 
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 38 ++++++++++++++--------
>  .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  6 ++++
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 12 +++++++
>  3 files changed, 43 insertions(+), 13 deletions(-)
> 
