From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jan 2018 10:57:08 -0200
Subject: [PATCH] ARM: dts: imx7s-warp: enable uart6 on mikroBus
In-Reply-To: <1516711050-2407-1-git-send-email-ryan.harkin@linaro.org>
References: <1516711050-2407-1-git-send-email-ryan.harkin@linaro.org>
Message-ID: <CAOMZO5ASy=6YNE=F=_A8DQLgvA6nqLuQUHhrCtZ4kMk5MaF2JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 10:37 AM, Ryan Harkin <ryan.harkin@linaro.org> wrote:
> This patch configures the board to output UART6 to the mikroBus.
>
> The NXP WaRP7 board can route UART6 to the mikroBus, where an RS232
> click board can be plugged in to get an additional serial port.
>
> Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
> Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
