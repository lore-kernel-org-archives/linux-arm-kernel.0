From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 27 Feb 2012 15:14:30 +0100
Subject: [PATCH v2 5/6] ARM: LPC32xx: serial.c: HW bug workaround
In-Reply-To: <1330184118-10270-6-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
 <1330184118-10270-6-git-send-email-stigge@antcom.de>
Message-ID: <20120227141430.GB3550@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 04:35:17PM +0100, Roland Stigge wrote:
> This patch fixes a HW bug by flushing RX FIFOs of the UARTs on init.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

If you have a reference (errata ID or similar) it would be nice to have
it in the comment and description.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/2da1299c/attachment.sig>
