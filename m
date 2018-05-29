From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 29 May 2018 15:40:18 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.18, part 2
In-Reply-To: <20180514135144.26872-1-dinguyen@kernel.org>
References: <20180514135144.26872-1-dinguyen@kernel.org>
Message-ID: <d634f5e4-5f20-d0bd-b92a-40b3ebc481c5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On 05/14/2018 08:51 AM, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in more updates for SoCFPGA Stratix10 DTS for v4.18.
> 
> Thanks,
> Dinh
> 
> The following changes since commit ab50a44404a53b12554005ed4c5a1b3547ac9492:
> 
>   arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts (2018-04-16 15:58:58 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_for_next_v4.18_dts_v2
> 
> for you to fetch changes up to 91fdd8274f32987760bbdb2981b4a896e338c09e:
> 
>   arm64: dts: stratix10: add sdram ecc (2018-05-08 08:11:29 -0500)
> 
> ----------------------------------------------------------------
> Bartosz Golaszewski (1):
>       ARM: dts: consistently use 'atmel' as at24 manufacturer in cyclone5
> 
> Ooi, Joyce (1):
>       arm64: dts: stratix10: Change pad skew values for EMAC0 PHY driver
> 
> Thor Thayer (1):
>       arm64: dts: stratix10: add sdram ecc
> 
>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts     |  6 +++---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 12 ++++++++++++
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts |  2 +-
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
