From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 12:45:11 +0100
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: Fix reboot hang
In-Reply-To: <1486494854-30802-1-git-send-email-festevam@gmail.com>
References: <1486494854-30802-1-git-send-email-festevam@gmail.com>
Message-ID: <20170308114509.GD12997@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 05:14:14PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> After issuing a 'reboot' command the imx6sx-udoo-neo board does not
> reboot as expected and it just hangs instead.
> 
> In mainline kernel only LDO enabled mode is supported. Do not provide
> arm-supply/soc-supply nodes in the device tree, so that the board operates
> in LDO enabled mode and can then successfully reboot via watchdog.
> 
> Fixes: 76e691fc7653b85d39 ("ARM: dts: imx6sx: Add UDOO Neo support")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
