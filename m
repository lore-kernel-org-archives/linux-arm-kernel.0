From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 Feb 2016 15:57:50 +0800
Subject: [PATCH 1/2] ARM: dts: imx25.dtsi: change the clock information
 for usb
In-Reply-To: <1455874504-28993-1-git-send-email-peter.chen@nxp.com>
References: <1455874504-28993-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20160228075750.GJ22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 05:35:03PM +0800, Peter Chen wrote:
> From: Peter Chen <peter.chen@freescale.com>
> 
> For imx25, it needs three clocks to let the controller work,
> the old code is wrong, and usbmisc has not included clock
> handling code any more.
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Applied both, thanks.
