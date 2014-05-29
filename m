From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 May 2014 16:26:18 +0800
Subject: [PATCH] ARM: dts: pfla02: Add ethernet phy supply regulator
In-Reply-To: <1401108176-25105-1-git-send-email-p.zabel@pengutronix.de>
References: <1401108176-25105-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140529082617.GI8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 02:42:56PM +0200, Philipp Zabel wrote:
> The 2.5V VDD_ETH_IO voltage supplied by the DA9063 LDO4 is used
> to power the KSZ9031 PHY DVDDH input and to pull the necessary
> pins (including bootstrap pins) high.
> It also powers the i.MX6 NVCC_RGMII and NVCC_ENET inputs.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
