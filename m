From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 10:38:23 +0800
Subject: [PATCH 1/2] ARM: imx: Make reset_control_ops const
In-Reply-To: <1456393482-26318-2-git-send-email-p.zabel@pengutronix.de>
References: <1456393482-26318-1-git-send-email-p.zabel@pengutronix.de>
 <1456393482-26318-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20160229023823.GM22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 10:44:41AM +0100, Philipp Zabel wrote:
> The imx_src_ops structure is never modified. Make it const.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
