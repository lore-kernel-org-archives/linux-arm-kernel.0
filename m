From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 7 Jan 2012 23:50:08 +0100
Subject: [PATCH v2 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <1325864366-17995-2-git-send-email-shawn.guo@linaro.org>
References: <1325864366-17995-1-git-send-email-shawn.guo@linaro.org>
 <1325864366-17995-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120107225008.GA24081@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 11:39:25PM +0800, Shawn Guo wrote:
> Both imx23 and imx28 have CHIPID register at address 0x8001c310, which
> can be used to identify the SoC.  This patch changes cpu_is_xxx and
> __arch_decomp_setup to use this CHIPID register than machine type to
> detect the chip between imx23 and imx28, so that we do not need to
> change these functions whenever a new board/machine gets added.
> 
> Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120107/f7b599b1/attachment-0001.sig>
