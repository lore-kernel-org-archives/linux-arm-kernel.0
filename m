From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Dec 2012 11:28:03 +0800
Subject: [PATCH] ARM: mxs_defconfig: Fix MTD_M25P80 selection
In-Reply-To: <1354557281-23760-1-git-send-email-fabio.estevam@freescale.com>
References: <1354557281-23760-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121204032802.GA24862@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 03:54:40PM -0200, Fabio Estevam wrote:
> commit 8f9d87a0 (ARM: mxs_defconfig: Add SPI and LRADC support) missed the
> '=y' annotation to CONFIG_MTD_M25P80.
> 
> Fix it, so that SPI Flash can be probed.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn
