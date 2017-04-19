From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:46:15 -0700
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.12
In-Reply-To: <1491835076-1995-3-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
 <1491835076-1995-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20170419134615.GZ29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 10:37:54PM +0800, Shawn Guo wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.12
> 
> for you to fetch changes up to e48d9e715411a70b6d7c589eb3284830f22f5bf7:
> 
>   ARM: dts: imx6q-utilite-pro: add hpd gpio (2017-04-10 16:16:24 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree updates for 4.12:
>  - New board support: I2SE's i.MX28 Duckbill-2 boards, Gateworks Ventana
>    i.MX6 GW5903/GW5904, Zodiac Inflight Innovations RDU2 board, Engicam
>    i.CoreM6 Quad/Dual OpenFrame modules, Boundary Device i.MX6 Quad Plus
>    SOM.
>  - Improve compatible string for i.MX50 eSDHC, i.MX7S SRC devices and
>    i.MX6SX UART device.
>  - Add interrupts for switch and PHY devices on VF610 ZII Devel C board.
>  - Add LVDS, LCD backlight, touchscreen and SAI2 support for i.MX6
>    icore, geam, and isiot boards.
>  - A series from Lucas Stach to improve i.MX6Q Plus device tree and add
>    PRE/PRG devices.
>  - A series from Stefan Agner to update imx7-colibri device tree
>    regarding to display, PMIC/regulator support.
>  - Fix PCI bus DTC warnings seen with the latest compiler.
>  - Set default phy_type and dr_mode for i.MX25 USBOTG port.
>  - A couple of small improvements on i.MX25 pin function DT header.
>  - Add audio support for imx6q-cm-fx6 board using Wolfson wm8731 codec
>    which is muxed to SSI2 device.
>  - Other random updates, small fixes and trivial cleanups.

Merged, thanks!


-Olof
