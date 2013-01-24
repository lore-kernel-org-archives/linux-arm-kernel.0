From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Jan 2013 14:07:47 +0800
Subject: [PATCH] ARM: mxs: dt: Add Crystalfontz CFA-10037 device tree
 support
In-Reply-To: <1358872551-14490-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1358872551-14490-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130124060744.GA16959@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 05:35:51PM +0100, Maxime Ripard wrote:
> The CFA-10037 is another expansion board for the CFA-10036 module, with
> only a USB Host, a Ethernet device and a lot of gpios.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/imx28-cfa10037.dts |   77 ++++++++++++++++++++++++++++++++++

Please add the dtb target into arch/arm/boot/dts/Makfile.

Shawn

>  arch/arm/mach-mxs/mach-mxs.c         |    8 ++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-cfa10037.dts
