From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 11:43:29 +0800
Subject: [PATCH v2] ARM: dts: imx: add Gateworks Ventana GW5600 support
In-Reply-To: <1493746777-7722-1-git-send-email-tharvey@gateworks.com>
References: <1492197481-16638-1-git-send-email-tharvey@gateworks.com>
 <1493746777-7722-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20170503034327.GA15612@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 10:39:37AM -0700, Tim Harvey wrote:
> The Gateworks Ventana GW5600 is a media-centric single-board computer based on
> the NXP IMX6 SoC with the following features:
>  * PoE (emulated 802.3af)
>  * IMX6 DualLite Soc (supports IMX6S,IMX6DL,IMX6Q)
>  * 1GiB DDR3 DRAM (supports up to 4GiB)
>  * 8GB eMMC
>  * 1x microSD connector
>  * Gateworks System Controller:
>   - hardware watchdog
>   - hardware monitor
>   - pushbutton controller
>   - EEPROM storage
>   - power control
>  * 1x bi-color USER LED
>  * 1x front-panel pushbutton
>  * 1x front-panel GbE
>  * 2x front panel USB 2.0
>  * 1x front panel USB OTG
>  * 1x SIM socket
>  * 1x miniPCIe socket with SATA (mSATA)
>  * 1x miniPCIe socket with USB 2.0 (Modem)
>  * 1x miniPCIe socket with PCIe, USB 2.0, and SIM
>  * RS232/RS485 serial
>   - 2x RS232 UARTs (off-board connector)
>   - 1x RS485 (loading option)
>  * 4x digital I/O signals (PWM/I2C/GPIO/5V/3.3V options)
>  * 1x analog input (0 to 5V)
>  * 1x CAN (loading option)
>  * off-board LVDS:
>   - I2C
>   - 12V
>   - LED driver (4x 330mA strings)
>   - matrix keypad controller (8row x 10col)
>   - I2S
>   - dual-channel LVDS
>   - PWM
>  * off-board video input:
>   - 16bit parallel / MIPI (IPU1_CSI0)
>  * GPS (loading option)
>  * Analog Video Input (CVBS) 3 inputs (1 active at a time)
>  * Analog Audio Input/Output (2ch Line level, optional MIC/HP drivers)
>  * HDMI out
>  * JTAG programmable
>  * Inertial Module
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
