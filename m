From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 May 2013 14:50:48 +0800
Subject: [PATCH v4 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <1369722012-6915-2-git-send-email-b32955@freescale.com>
References: <1369722012-6915-1-git-send-email-b32955@freescale.com>
 <1369722012-6915-2-git-send-email-b32955@freescale.com>
Message-ID: <20130528065047.GC19608@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, May 28, 2013 at 02:20:07PM +0800, Huang Shijie wrote:
> The WEIM(Wireless External Interface Module) works like a bus.
> You can attach many different devices on it, such as NOR, onenand.
> 
> In the case of i.MX6q-sabreauto, the NOR is connected to WEIM.
> 
> This patch also adds the devicetree binding document.
> The driver only works when the devicetree is enabled.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt |   49 +++++++
>  drivers/bus/Kconfig                                |    9 ++
>  drivers/bus/Makefile                               |    1 +
>  drivers/bus/imx-weim.c                             |  138 ++++++++++++++++++++

What's the general merge path for drivers/bus/ ones?  It's not clear to
me who is collecting those drivers/bus/ patches.

Shawn

>  4 files changed, 197 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
>  create mode 100644 drivers/bus/imx-weim.c
