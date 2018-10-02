From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 11:41:13 +0200
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.20
In-Reply-To: <20181001072003.16238-3-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
 <20181001072003.16238-3-shawnguo@kernel.org>
Message-ID: <CAK8P3a11OXxQ-vf2fXTnr1Dqx5Bgvext26orEpM99ZTQJTGngg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 9:20 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> ----------------------------------------------------------------
> i.MX device tree update for 4.20:
>  - New board support: Engicam's i.Core MX6 CPU module v1.5; ConnectCore
>    6UL Single Board Computer (SBC) Pro; i.MX6 ULZ based EVK board.
>  - Add Add SFF interface support for vf610-zii board.
>  - Disable unneeded devices like VPU and internal watchdog for imx51-zii
>    boards.
>  - Add 'no-sdio' and 'no-sd' property for vf610-zii-cfu1 board.
>  - Improve i.MX6 SLL GPIO support by adding gpio-ranges property and
>    clocks information.
>  - Update iomux header for i.MX7 Solo and i.MX6 ULL.
>  - Enable GPIO buttons as wakeup source for imx7d-sdb and imx6sx-sdb.
>  - Add GPIO keys and egalax touch screen support for imx6qdl-sabreauto.
>  - Switch to use SPDX-License-Identifier for more boards - vf610-twr,
>    imx7s-warp, Engicam boards.
>  - Add device tree bindings of 'fsl,pmic-stby-poweroff' property and add
>    the support for i.MX6 RIoTboard.
>  - DTC has new checks for SPI buses which will be landed on 4.20.
>    A patch from Rob to fix those 100+ warnings on i.MX boards. (Thanks!)
>  - Switch i.MX7 device tree to use updated coresight binding for
>    hardware ports.
>  - Misc small or random update and cleanup.

Pulled into next/dt, thanks!

      Arnd
