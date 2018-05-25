From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 13:53:06 -0700
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.18
In-Reply-To: <1526828281-14664-3-git-send-email-shawnguo@kernel.org>
References: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
 <1526828281-14664-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20180525205306.dr5jvl3bqpzmzvwm@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 10:57:59PM +0800, Shawn Guo wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.18
> 
> for you to fetch changes up to 204d9e32b7971ecd187068c3a40c48bac4656cb0:
> 
>   ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source (2018-05-20 21:04:59 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree update for 4.18:
>  - New boards support: BTicino i.MX6DL Mamoj board, DHCOM iMX6 SoM and
>    PDK2 board, Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit,
>    Kieback & Peter GmbH iMX6Q TPC board.
>  - A series from Anson Huang to add a bunch of devices for i.MX6SX
>    SabreAuto board, PMIC, IO expanders, FEC, Watchdog, LED and Touch.
>  - Update i.MX7D for cpufreq support, using operating-points-v2
>    bindings, correcting cpu supply name for voltage scaling.
>  - Clean up unneeded 'codec-handle' property from imx25-pdk and
>    imx53-tx53 device tree.
>  - Switch SoC dtsi and NXP board dts files to use SPDX identifier.
>  - Remove unnecessary '#address-cells/#size-cells' to fix DTC warning
>    avoid_unnecessary_addr_size seen with W=1 switch.
>  - A series from Rob Herring to fix DTC warning graph_endpoint seen with
>    IPU OF graph when W=1 switch is on.
>  - Update a few boards to use symbol name instead of hard-coding the
>    input codes.
>  - Update a number of boards to use IRQ_TYPE specifier instead of the
>    raw value.
>  - A few updates for i.MX6 RDU2 board: bumping SoC/PU operating points,
>    adding assigned clocks for GPU, and enabling eGalax touchscreen.
>  - A couple of i.MX51 RDU1 updates: limiting usbh1 to full-speed, and
>    cleaning up eMMC device node.
>  - Convert Hummingboard audio bindings from imx-audio-sgtl5000 to
>    simple-audio-card, so that auxiliary audio devices such as external
>    amplifiers can be supported.
>  - Replace underscore with hyphen in aliases name to fix DTC warning
>    alias_paths with W=1 switch.
>  - A couple of updates on i.MX7D SAI and i.MX6ULL UART5 pin defines.
>  - Other random and small changes.

Nice! Merged now, thanks.



-Olof
