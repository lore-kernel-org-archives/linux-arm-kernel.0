From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:24:50 +0100
Subject: [PATCH v2 2/7] LPC32xx: clock.c: jiffies wrapping
In-Reply-To: <1327939327-7799-2-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <1327939327-7799-2-git-send-email-stigge@antcom.de>
Message-ID: <20120131102450.GG2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:02:01PM +0100, Roland Stigge wrote:
> This patch fixes the jiffies wrapping bug in clock.c.
> 
> It corrects the timeout computation based on jiffies, uses time_before() for
> correct wrapping handling and replaces a binary "&" which should really be a
> logical "&&" in a truth expression.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de> 
Tested-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/a40c1742/attachment.sig>
