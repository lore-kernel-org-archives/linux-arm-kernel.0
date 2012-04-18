From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 18 Apr 2012 20:04:20 +0200
Subject: [PATCH v3 7/8] i2c-pnx.c: Remove duplicated i2c.h
In-Reply-To: <1333528480-17134-8-git-send-email-stigge@antcom.de>
References: <1333528480-17134-1-git-send-email-stigge@antcom.de>
 <1333528480-17134-8-git-send-email-stigge@antcom.de>
Message-ID: <20120418180420.GC2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 10:34:39AM +0200, Roland Stigge wrote:
> The platforms using i2c-pnx.c both defined a duplicated i2c.h (used nowhere
> else). This patch removes those and integrates the contents into the driver
> itself.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Applied to next, thanks.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/7fb94077/attachment.sig>
