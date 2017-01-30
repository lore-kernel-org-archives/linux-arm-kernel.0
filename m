From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:08:34 -0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.11
In-Reply-To: <1485662803-31235-3-git-send-email-shawnguo@kernel.org>
References: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
 <1485662803-31235-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130050834.GR18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:06:41PM +0800, Shawn Guo wrote:

> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.11
> 
> for you to fetch changes up to 18ba386826f143dc4177830cc7c24c7abf4de4be:
> 
>   ARM: dts: udoo_neo: Add Bluetooth support (2017-01-29 10:04:06 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree updates for 4.11:
>  - New board support: vf610-zii-dev-rev-c, imx6ul-opos6uldev,
>    imx6ul-isiot, imx6qdl-savageboard, imx6q-mccmon6.
>  - A patch from Alexandre to correct the mangled license text which
>    has been copied & pasted all over the i.MX device tree files.
>  - Update cpu nodes of some i.MX SoCs to make them consistent and match
>    ePAPR spec.
>  - Add OCOTP device for i.MX6UL SoC.
>  - Add security violation interrupt for i.MX25 DryIce.
>  - Enable USB OTG, WIFI and Bluetooth support for i.MX6SX Udoo Neo
>    board.
>  - Enable S/PDIF and 2nd display pipeline support for CompuLab board..
>  - Add SPI and LTC3676 PMIC support for Gateworks Ventana boards.
>  - A few random device addition for various boards: TVE DAC regulators
>    for imx53-qsb, EEPROM for vf610-zii-dev, eMMC and NAND support for
>    i.MX6UL Engicam boards.
>  - Cleanups on obsoleted or unused properties.

Merged, thanks!


-Olof
