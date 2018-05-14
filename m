From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:09:56 -0700
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.18
In-Reply-To: <5AF5A668.8010903@hisilicon.com>
References: <5AF5A668.8010903@hisilicon.com>
Message-ID: <20180514200956.jzvglfib3kgjf6xs@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 11, 2018 at 03:19:20PM +0100, Wei Xu wrote:
> Hi Arnd, Hi Olof,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.18
> 
> for you to fetch changes up to 84f7ed0f22e8eb42e81b69cd7772c3600c9f4959:
> 
>   arm64: dts: hi3798cv200: enable emmc support for poplar board (2018-05-11 11:23:10 +0100)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoC DT updates for 4.18
> 
> - Add mailbox, stub clock, CPU frequency scaling, thermal cooling
>   management and pcie msi interruption support for hi3660
> - Add LPC support for hip06 and hip07
> - Add PCIe, usb and emmc support for hi3798cv200
> 
> ----------------------------------------------------------------
> John Garry (2):
>       arm64: dts: hisi: Enable Hisi LPC node for hip06
>       arm64: dts: hisi: Enable Hisi LPC node for hip07
> 
> Kaihua Zhong (2):
>       dts: arm64: hi3660: Add mailbox node
>       dts: arm64: hi3660: Add stub clock node
> 
> Leo Yan (1):
>       dts: arm64: hi3660: Add CPU frequency scaling support
> 
> Shawn Guo (3):
>       arm64: dts: hi3798cv200: enable PCIe support for poplar board
>       arm64: dts: hi3798cv200: enable usb2 support for poplar board
>       arm64: dts: hi3798cv200: enable emmc support for poplar board
> 
> Tao Wang (1):
>       dts: arm64: hi3660: Add thermal cooling management
> 
> Yao Chen (1):
>       arm64: dts: hi3660: Add pcie msi interrupt attribute

We try to use a very consistent patch prefix format on device tree changes to
make it easier to get an overview, and you're unfortunately a bit inconsistent
here.

Would you mind respinning this with "arm64: dts: hi<...>:" as the consistent
prefix please?


Thanks!


-Olof
