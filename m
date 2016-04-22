From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 22 Apr 2016 10:03:40 -0500
Subject: [PATCH] ARM: socfpga: dts: Add samtec VIN|ING board
In-Reply-To: <1460550298-9533-1-git-send-email-marex@denx.de>
References: <1460550298-9533-1-git-send-email-marex@denx.de>
Message-ID: <571A3D4C.4050807@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2016 07:24 AM, Marek Vasut wrote:
> Add support for board based on the popular Altera Cyclone V SoC.
> This board has the following properties:
>  - 1 GiB of DRAM
>  - 1 Gigabit ethernet
>  - 1 USB gadget port
>  - 1 USB host port with an on-board hub
>  - 2 QSPI NORs connected to the Cadence QSPI core
>  - Multiple I2C EEPROMs and one I2C temperature sensor
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 310 +++++++++++++++++++++
>  2 files changed, 311 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts

Minor nit for next time. The arm-soc maintainers would like the commit
head for DTS to be: "ARM: dts: <platform>".

I fixed it up and applied.

Thanks,
Dinh
