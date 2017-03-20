From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 20 Mar 2017 15:31:12 +0800
Subject: [PATCH v3] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <1489674440-14432-1-git-send-email-tharvey@gateworks.com>
References: <1489178411-6559-1-git-send-emai-tharvey@gateworks.com>
 <1489674440-14432-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20170320073111.GB3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 07:27:19AM -0700, Tim Harvey wrote:
> The Gateworks Ventana GW5904 is a single-board computer based on the NXP
> IMX6 SoC with the following features:
>  * IMX6 DualLite Soc (supports IMX6S,IMX6DL,IMX6Q)
>  * 2048MB DDR3 DRAM (4x64bit) (options up to 4GiB)
>  * 8GB eMMC
>  * Gateworks System Controller:
>   - hardware watchdog
>   - hardware monitor
>   - pushbutton controller
>   - EEPROM storage
>   - power control
>  * JTAG programmable
>  * 1x miniPCIe socket (with PCIe, USB)
>  * 1x miniPCIe socket (USB)
>  * 1x M.2 socket (USB, 2x SIM)
>  * Inertial Module (LSM9DS1 9DOF: 3x acc, 3x rate, 3x mag)
>  * GPS (optional uBlox EVA-M8M)
>  * Application headers:
>   - 2x RS232 UART (TX/RX/CTS/RTS)
>   - 8x TTL GPIO (3x configurable as PWM)
>   - 1x LVDS display 3D+C with i2c touch and PWM backlight
>  * MV88E6176 GbE Switch (uplink to IMX FEC)
>  * Front panel connectors:
>   - 1x user programmable LED
>   - 1x configurable user pushbutton
>   - 1x USB OTG
>   - 4x GbE LAN
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
