From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 17:36:06 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Pass the correct PCI reset
 polarity
In-Reply-To: <1465178447-24655-1-git-send-email-festevam@gmail.com>
References: <1465178447-24655-1-git-send-email-festevam@gmail.com>
Message-ID: <20160611093606.GK20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2016 at 11:00:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The PCI reset GPIO is active low, so represent it with the
> GPIO_ACTIVE_LOW flag.
> 
> Even though the imx6 PCI driver will not take the polarity into account
> in this case, it is better to provide a correct description in device-tree.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
