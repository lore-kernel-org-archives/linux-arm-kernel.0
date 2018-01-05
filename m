From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 17:11:11 +0100
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.16
In-Reply-To: <1514959040-9992-3-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
 <1514959040-9992-3-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a2f930bvL44JOt-AqVypikz0TT-FFfzsV7_bTTG9XwmeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 6:57 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:
>
>   Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.16
>
> for you to fetch changes up to 84a82ef70e1eb2a7a90bc19eed27cb27a8e4c54c:
>
>   ARM: dts: imx7s: Avoid using label in unit address and reg (2017-12-27 10:52:39 +0800)
>
> ----------------------------------------------------------------
> i.MX device tree changes for 4.16:
>  - A few random updates for vf610-zii board: correct switch EEPROM size,
>    enable edma1, correct GPIO expander interrupt, add PHYs for switch2
>    device.
>  - LS1021A device tree updates: add reboot and QSPI device nodes, label
>    USB controllers, specify interrupt-affinity for PMU, fix TMR_FIPER1
>    setting, enable esdhc device, add Moxa UC-8410A board support.
>  - A bunch of patches from Fabio: fix reg - unit address mismatches,
>    remove leading zero in unit address, move regulators out of
>    simple-bus, move nodes with no reg property out of bus, remove extra
>    clock cell, add missing phy-cells to usb-nop-xceiv, etc.
>  - A couple series from Hummingboard developers: re-organise device tree
>    files for better handling various board versions, and then add the
>    new hummingboard2 board support on top of that.
>  - Disable AC'97 input pins pad and add support for powering off for
>    imx6qdl-udoo board.
>  - Convert from fbdev to drm bindings for imx6sx-sdb and imx6sl-evk
>    board.
>  - Add device tree for Variscite DART-MX6 SoM and Carrier-board support.
>  - Add new board support of TS-4600 and TS-7970 from Technologic
>    Systems.
>  - A series from Stefan to update imx7-colibri device tree and then add
>    new version of Toradex Colibri iMX7D board with eMMC support.
>  - Other random updates on various board support.

Nice changelog, pulled into next/dt, thanks!

       Arnd
