From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 19 May 2017 10:16:44 +0800
Subject: [PATCH] ARM: dts: imx6sx-sdb: Properly model the ARM and SOC
 regulator supplies
In-Reply-To: <1494858309-10221-1-git-send-email-festevam@gmail.com>
References: <1494858309-10221-1-git-send-email-festevam@gmail.com>
Message-ID: <20170519021643.GB26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 11:25:09AM -0300, Fabio Estevam wrote:
> On imx6sx-sdb rev B/C the VDD_ARM_IN and VDD_SOC_IN supplies are connected
> together and both are supplied by the SW1A PMIC output, so model this
> correctly in the device tree.
> 
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
