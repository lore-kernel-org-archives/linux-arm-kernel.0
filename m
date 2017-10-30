From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 14:40:00 +0100
Subject: [GIT PULL 3/4] Freescale arm64 device tree updates for 4.15
In-Reply-To: <1508847645-9191-3-git-send-email-shawnguo@kernel.org>
References: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
 <1508847645-9191-3-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a2FPBo_BWi6X4oNJ3L2umfRTKMuak=0=T2yq5MeKNasxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 2:20 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> ----------------------------------------------------------------
> Freescale arm64 device tree updates for 4.15:
>  - Add GICv3 ITS node and PCIe devcies for LS1088A support.
>  - Enable PCIe support for LS2088A SoC.
>  - Add OP-TEE support for various Layerscape SoCs, LS1012A, LS1043A,
>    LS1046A, LS1088A and LS208XA.
>  - Update DPAA QBMan nodes to use constant defines in the interrupt
>    description.
>  - Add DSPI device to support SPI-NOR on LS1012A based boards.

Pulled into next/dt, thanks!

       Arnd
