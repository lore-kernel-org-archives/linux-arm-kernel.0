From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Jun 2013 23:09:37 +0800
Subject: [PATCH v4 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <1369722012-6915-2-git-send-email-b32955@freescale.com>
References: <1369722012-6915-1-git-send-email-b32955@freescale.com>
 <1369722012-6915-2-git-send-email-b32955@freescale.com>
Message-ID: <20130606150935.GD28270@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
>  4 files changed, 197 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
>  create mode 100644 drivers/bus/imx-weim.c

Since no one is collecting drivers/bus/ patches right now, I just
applied the whole series to have the patch go via imx -> arm-soc.
Please let me know if there is any problem.

Shawn
