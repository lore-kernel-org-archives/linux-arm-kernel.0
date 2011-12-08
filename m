From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 8 Dec 2011 09:53:40 +0100
Subject: [MXS MMC v2 3/4] Check the return codes of clk_enable() and
 mxs_reset_block()
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323328267.git.LW@KARO-electronics.de>
References: <cover.1323328267.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323328267.git.LW@KARO-electronics.de>
Message-ID: <20111208085340.GD23908@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 09:17:46AM +0100, Lothar Wa?mann wrote:
> Add an int return value to mxs_mmc_reset(), so that the return code of
> mxs_reset_block() can be promoted to the caller.
> Also check the return code of clk_enable() in the probe function.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Despite minor nit that using __func__ is probably overkill:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111208/b700d403/attachment.sig>
