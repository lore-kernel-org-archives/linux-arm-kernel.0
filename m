From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 5 Jun 2018 14:41:28 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.18
In-Reply-To: <1524494393-8052-1-git-send-email-dinguyen@kernel.org>
References: <1524494393-8052-1-git-send-email-dinguyen@kernel.org>
Message-ID: <8f2dd217-0005-5d6e-9fd2-46432b4a8208@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, and Arnd:

Perhaps this pull request got buried in your inbox somewhere?

There are a few patches that touches the socfpga_stratix10.dtsi that are
in the EDAC branch that is dependent on these patches, so Boris is
taking these patches through his edac changes for v4.18.

Dinh

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
