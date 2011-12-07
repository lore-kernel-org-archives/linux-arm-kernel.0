From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 20:33:05 +0800
Subject: [MXS MMC 4/5] Check the return codes of clk_enable() and
 mxs_reset_block()
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
Message-ID: <20111207123304.GN5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 02:41:29PM +0100, Lothar Wa?mann wrote:
> Add an int return value to mxs_mmc_reset(), so that the return code of
> mxs_reset_block() can be promoted to the caller.
> Also check the return code of clk_enable() in the probe function.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
