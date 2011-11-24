From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Nov 2011 09:00:04 +0100
Subject: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
In-Reply-To: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111124080004.GD8439@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
>   CC      drivers/i2c/busses/i2c-mxs.o
> drivers/i2c/busses/i2c-mxs.c: In function ?mxs_i2c_xfer?:
> drivers/i2c/busses/i2c-mxs.c:196:6: warning: ?data? may be used uninitialized in this function
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Which compiler? What flags? I don't see that here.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111124/780636bf/attachment.sig>
