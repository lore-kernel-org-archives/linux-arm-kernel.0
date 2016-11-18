From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 10:32:00 -0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.10
In-Reply-To: <1479200431-1765-3-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
 <1479200431-1765-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20161118183200.GF8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 05:00:29PM +0800, Shawn Guo wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.10
> 
> for you to fetch changes up to c201369d4aa5f05b8a37d6d1eeabf248c7086454:
> 
>   ARM: dts: imx6ull: add imx6ull support (2016-11-15 08:54:27 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree updates for 4.10:
>  - New boards support: i.MX6SX UDOO Neo, Boundary Devices Nitrogen6_SOM2,
>    Engicam i.CoreM6, Grinn i.MX6UL liteSOM/liteBoard, Toradex Colibri
>    iMX6 module, i.MX6ULL and EVK board.
>  - Remove skeleton.dtsi inclusion from all i.MX SoC dts files, as it's
>    been deprecated, since commit 9c0da3cc61f1233c ("ARM: dts: explicitly
>    mark skeleton.dtsi as deprecated").
>  - Misc device addition and enabling: OCOTP for Vybrid, MMDC for i.MX6QP,
>    TMU for LS1021A, FEC for imx6qdl-icore, DMA for Vybrid DSPI.
>  - A few cleanups: use hyphens for node names, fix white spaces, move
>    imx-weim parameters into SoC dtsi, replace gpio-key,wakeup with
>    wakeup-source, remove pwm-leds from imx6q-apalis-ixora, remove I2C3
>    from vf610-zii-dev-rev-b.
>  - Other small random changes: calibrate USB PHY for b650v3 board,
>    update TX D_CAL for USBPHY, use enable-gpios for backlight on
>    imx6qdl-apalis, etc.

Merged, thanks.


-Olof
