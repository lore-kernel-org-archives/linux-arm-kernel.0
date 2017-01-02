From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 2 Jan 2017 14:04:16 +0800
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: Pass the 'phy-reset-duration'
 property
In-Reply-To: <1480966119-17350-1-git-send-email-festevam@gmail.com>
References: <1480966119-17350-1-git-send-email-festevam@gmail.com>
Message-ID: <20170102060415.GA5700@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 05:28:39PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx6sx-udoo-neo has a KSZ8091 Ethernet PHY, which requires the reset
> signal to be low for at least 10ms.
> 
> Pass the 'phy-reset-duration' property to reflect such requirement.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
