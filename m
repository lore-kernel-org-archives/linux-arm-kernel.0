From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 21:39:25 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select HCIUART_H4
In-Reply-To: <1435583143-4734-2-git-send-email-fabio.estevam@freescale.com>
References: <1435583143-4734-1-git-send-email-fabio.estevam@freescale.com>
 <1435583143-4734-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150713133925.GQ23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 10:05:43AM -0300, Fabio Estevam wrote:
> The old warp board revision had hardware issues that prevented
> the RTS/CTS lines to work with the Bluetooth module.
> 
> Tha latest rev1.12 fixes this problem, so now we should better use
> CONFIG_BT_HCIUART_H4 instead, as it provides a better throughput than
> the CONFIG_BT_HCIUART_3WIRE option.
> 
> Suggested-by: Arthur Lambert <arthur@dreem.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
