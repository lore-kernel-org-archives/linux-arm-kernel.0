From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 18 Apr 2012 19:57:59 +0200
Subject: [PATCH v3 5/8] i2c-pnx.c: Fix suspend
In-Reply-To: <1333528480-17134-6-git-send-email-stigge@antcom.de>
References: <1333528480-17134-1-git-send-email-stigge@antcom.de>
 <1333528480-17134-6-git-send-email-stigge@antcom.de>
Message-ID: <20120418175759.GA2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 10:34:37AM +0200, Roland Stigge wrote:
> In the driver's suspend function, clk_enable() was used instead of
> clk_disable(). This is corrected with this patch.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> CC: stable at vger.kernel.org

Picked up for 3.4, reworded the message header to "i2c: pnx: Disable
clk in suspend" since "fix suspend" was too generic.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/d5cb7514/attachment.sig>
