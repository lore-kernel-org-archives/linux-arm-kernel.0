From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 18 Apr 2012 20:03:59 +0200
Subject: [PATCH v3 6/8] i2c-pnx.c: Use resources in platforms
In-Reply-To: <1333528480-17134-7-git-send-email-stigge@antcom.de>
References: <1333528480-17134-1-git-send-email-stigge@antcom.de>
 <1333528480-17134-7-git-send-email-stigge@antcom.de>
Message-ID: <20120418180359.GB2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 10:34:38AM +0200, Roland Stigge wrote:
> As a precondition for device tree conversion, the platforms using i2c-pnx.c are
> converted to using mem and irq resources instead of platform data.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I trust you and Arnd on the mach stuff. i2c looked okay, devm_*
could have been used, but well... Applied to next.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/1a060666/attachment.sig>
