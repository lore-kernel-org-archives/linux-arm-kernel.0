From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:34:01 +0100
Subject: [PATCH v2 6/7] LPC32xx: clock.c: USB PLL fix
In-Reply-To: <1327939327-7799-6-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <1327939327-7799-6-git-send-email-stigge@antcom.de>
Message-ID: <20120131103401.GJ2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:02:05PM +0100, Roland Stigge wrote:
> This patch fixes and updates the USB PLL handling. With the old driver version,
> the USB clock was sometimes not started correctly. The update reflects the
> driver changes in this regard from Kevin Wells.
> 
> See also git.lpclinux.com
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

I remember we needed that fix back then as well, so I am tempted to ack
it. However, I'd like to test it but USB is currently not available. Do
you happen to have a USB fixing commit just to test (can be hackish)?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/98fc752a/attachment.sig>
