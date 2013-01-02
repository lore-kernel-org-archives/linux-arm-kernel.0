From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Jan 2013 11:22:57 +0100
Subject: [PATCH 2/2] ARM: dts: imx: use nodes label in board dts
In-Reply-To: <1356925757-5704-2-git-send-email-shawn.guo@linaro.org>
References: <1356925757-5704-1-git-send-email-shawn.guo@linaro.org>
 <1356925757-5704-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130102102257.GF26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 31, 2012 at 11:49:17AM +0800, Shawn Guo wrote:
> Following omap3-evm.dts way, it changes all imx dts files to use label
> in board dts to refer to nodes defined by soc dtsi.  Thus, the board
> dts files become easier to read and edit with the least indentation
> levels.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Nice!

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
