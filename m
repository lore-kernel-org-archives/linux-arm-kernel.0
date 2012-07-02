From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Jul 2012 10:24:34 +0800
Subject: [PATCH v3 2/3] ARM: imx6q: add DT node for gpmi nand
In-Reply-To: <1341200327-8144-3-git-send-email-shijie8@gmail.com>
References: <1341200327-8144-1-git-send-email-shijie8@gmail.com>
 <1341200327-8144-3-git-send-email-shijie8@gmail.com>
Message-ID: <20120702022433.GD21003@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 01, 2012 at 11:38:46PM -0400, Huang Shijie wrote:
> Add the DT node for gpmi nand.
> Add the pinmux support for gpmi nand.
> 
> The gpmi nand may conflicts with other modules, such as MMC.
> So we do not enable the gpmi nand for mx6q-arm2 board, just add the
> node for the board.
> 
> Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

Applied, thanks.

-- 
Regards,
Shawn
