From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Nov 2014 18:50:45 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Enable CODA960 VPU
In-Reply-To: <1415740367-326-1-git-send-email-festevam@gmail.com>
References: <1415740367-326-1-git-send-email-festevam@gmail.com>
Message-ID: <20141112105044.GL2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 07:12:47PM -0200, Fabio Estevam wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> This patch adds links to the on-chip SRAM and reset controller nodes
> and switches the interrupts. Make the BIT processor interrupt, which exists on
> all variants, the first one. The JPEG unit interrupt, which does not exist on
> i.MX27 and i.MX5 thus is an optional second interrupt.
> Use different compatible strings for i.MX6Q/D and i.MX6S/DL, as they have to
> load separate firmware images for some reason.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
