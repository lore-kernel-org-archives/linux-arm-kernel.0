From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 29 May 2018 15:39:55 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.18
In-Reply-To: <1524494393-8052-1-git-send-email-dinguyen@kernel.org>
References: <1524494393-8052-1-git-send-email-dinguyen@kernel.org>
Message-ID: <f2304b65-7add-3a97-1ee8-b0d1ece33005@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On 04/23/2018 09:39 AM, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please full in these SoCFPGA Stratix10 DTS updates for v4.18.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.18_part1
> 
> for you to fetch changes up to ab50a44404a53b12554005ed4c5a1b3547ac9492:
> 
>   arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts (2018-04-16 15:58:58 -0500)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v4.18
> - Stratix10 platform updates
>   - Populate clock properties for platform
>   - Enable DMA and I2C
> 
> ----------------------------------------------------------------
> Alan Tull (1):
>       arm64: dts: stratix10: enable i2c, add i2c periperals
> 
> Dinh Nguyen (1):
>       arm64: dts: stratix10: use clock bindings for the Stratix10 platform
> 
> Graham Moore (1):
>       arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts
> 
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 71 +++++++++++++++++++++-
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 42 +++++++++++++
>  2 files changed, 111 insertions(+), 2 deletions(-)
> 
