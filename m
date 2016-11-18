From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:29:41 -0800
Subject: [GIT PULL 1/2] SoCFPGA DTS updates for v4.10
In-Reply-To: <20161111205915.22173-1-dinguyen@kernel.org>
References: <20161111205915.22173-1-dinguyen@kernel.org>
Message-ID: <20161118072941.GG1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 02:59:14PM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in part 2 of these DTS updates for v4.10.
> 
> Thanks,
> Dinh
> 
> The following changes since commit c96f5919e6b0d132aa9afe9f1adc872fc107d5bb:
> 
>   ARM: dts: socfpga: socrates: enable qspi (2016-10-18 22:18:14 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.10_part_2
> 
> for you to fetch changes up to d837a80d19505d74ee5941eebf9dd53fed6f36a6:
> 
>   ARM: dts: socfpga: add nand controller nodes (2016-11-09 12:40:52 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS update for v4.10, part 2
> - Add specific compatible strings for variants of Cyclone5 boards
> - Add QSPI node on Arria10
> - Enable QSPI on Arria5 and Arria10 devkit, and Cyclone5 SoCKit
> - Add NAND controller node on Cyclone5
> 
> ----------------------------------------------------------------
> Dinh Nguyen (6):
>       ARM: dts: socfpga: add specific compatible strings for boards
>       ARM: dts: socfpga: enable qspi on the Cyclone5 devkit
>       ARM: dts: socfpga: Add QSPI node for the Arria10
>       ARM: dts: socfpga: Enable QSPI in Arria10 devkit
>       ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
>       ARM: dts: socfpga: Enable QSPI on the Arria5 devkit
> 
> Steffen Trumtrar (1):
>       ARM: dts: socfpga: add nand controller nodes
> 
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/socfpga.dtsi                     | 13 ++++++
>  arch/arm/boot/dts/socfpga_arria10.dtsi             | 14 +++++++
>  arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts   | 49 ++++++++++++++++++++++
>  arch/arm/boot/dts/socfpga_arria5_socdk.dts         | 33 +++++++++++++++
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 35 +++++++++++++++-
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      | 23 +++++++++-
>  arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |  2 +-
>  11 files changed, 170 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts

Merged, thanks!


-Olof
