From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 12 Aug 2016 14:53:53 -0500
Subject: [PATCH] ARM: dts: socfpga: Add Macnica sodia board
In-Reply-To: <1469482208-5071-1-git-send-email-iwamatsu@nigauri.org>
References: <1469482208-5071-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <57AE2951.3050404@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2016 04:30 PM, Nobuhiro Iwamatsu wrote:
> Add support for board based on the Altera Cyclone V SoC.
> This board has the following functions:
>     - 1 GiB of DRAM
>     - 1 Gigabit ethernet
>     - 1 SD card slot
>     - 1 USB gadget port
>     - QSPI NOR Flash
>     - I2C EEPROMs and I2C RTC
>     - DVI output
>     - Audio port
> 
> This commit supports without QSPI, DVI and Audio.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/arm/boot/dts/Makefile                   |   1 +
>  arch/arm/boot/dts/socfpga_cyclone5_sodia.dts | 115 +++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
> 

Applied!

Thanks,
Dinh
