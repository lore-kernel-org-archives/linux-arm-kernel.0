From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 May 2012 23:56:02 -0700
Subject: [GIT PULL] imx device tree changes for v3.5
In-Reply-To: <20120512030722.GD17875@S2101-09.ap.freescale.net>
References: <20120512030722.GD17875@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMj3Up4GASQ0O6L41U=DNQjk1A361xRBDfFuiGnM2AjL3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 8:07 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Arnd, Olof,
>
> Please pull the following imx device tree changes for v3.5. ?I chose
> to base it on Sascha's imx-common-clk series than -rc, because otherwise
> it will keep patching clock file that has been removed by imx-common-clk
> series. ?It also depends on imx-pinctrl pull-request I just sent to be
> functional.
>
> Note: when imx-common-clk and imx-pinctrl get merged together, the
> following files will have conflicts. ?But the conflicts should not be
> so hard to resolve.
>
> ? ?Conflicts:
> ? ? ? ?drivers/mmc/host/sdhci-esdhc-imx.c
> ? ? ? ?drivers/net/ethernet/freescale/fec.c
> ? ? ? ?drivers/spi/spi-imx.c
> ? ? ? ?drivers/tty/serial/imx.c
>
> If you prefer, I can rebase my imx-pinctrl on top of imx-common-clk
> to save the conflicts.

Pulled, thanks. The conflicts were reasonably contained, but please
make sure I resolved them right.


-Olof
