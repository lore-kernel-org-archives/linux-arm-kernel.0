From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Dec 2017 10:38:18 +0800
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <1514311460-8840-1-git-send-email-festevam@gmail.com>
References: <1514311460-8840-1-git-send-email-festevam@gmail.com>
Message-ID: <20171227023817.GZ23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 04:04:20PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 915fbe59cbf2fe6 ("ARM: dts: imx: Add missing #phy-cells to
> usb-nop-xceiv") missed to update imx51-zii-rdu1.dts probably due to a
> merge timing issue, so add #phy-cells here too. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
