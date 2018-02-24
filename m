From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 15:51:27 +0800
Subject: [PATCH] ARM: dts: imx6: RDU2: detail USDHC description
In-Reply-To: <20180212130818.12665-1-l.stach@pengutronix.de>
References: <20180212130818.12665-1-l.stach@pengutronix.de>
Message-ID: <20180224075126.GH3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 02:08:18PM +0100, Lucas Stach wrote:
> None of the slots support 1.8V signaling or SDIO. There is no point in
> probing for a SD card on the eMMC controller.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
