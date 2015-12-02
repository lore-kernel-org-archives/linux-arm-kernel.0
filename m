From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 16:03:28 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable PCI_MSI
In-Reply-To: <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
References: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
 <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20151202080328.GQ692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 06:00:11PM +0100, Lucas Stach wrote:
> This has been stable on i.MX6 for a good while now and there is no
> reason to keep it disabled, as it allows to allocate non-shared
> IRQs if several PCIe devices are connected to a single host.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
