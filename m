From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 22:20:51 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Fix CODA960 interrupt order
In-Reply-To: <1417188226-21756-1-git-send-email-p.zabel@pengutronix.de>
References: <1417188226-21756-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20141202142048.GN2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 04:23:46PM +0100, Philipp Zabel wrote:
> Commit a04a0b6fed4f ("ARM: dts: imx6qdl: Enable CODA960 VPU") lost the
> fix for the CODA960 interrupt order during a rebase before being applied.
> This patch adds the missing bit and brings the interrupts and
> interrupt-names properties back in sync.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
