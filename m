From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Mar 2014 13:22:21 +0800
Subject: [PATCH 1/3] ARM: dts: imx6: extend PCIe interrupt list for MSI
In-Reply-To: <1393608633-18321-2-git-send-email-l.stach@pengutronix.de>
References: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
 <1393608633-18321-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140303052216.GC9706@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 06:30:31PM +0100, Lucas Stach wrote:
> Optional IRQ necessary for handling MSI.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 9 ++++++++-

Please have this change go with driver or a separate patch, not with
dts update.

Shawn

>  arch/arm/boot/dts/imx6qdl.dtsi                           | 4 +++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
