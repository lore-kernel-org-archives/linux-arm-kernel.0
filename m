From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 27 Feb 2012 16:48:48 +0100
Subject: [PATCH v2 5/6] ARM: LPC32xx: serial.c: HW bug workaround
In-Reply-To: <4F4BA31F.8040201@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
 <1330184118-10270-6-git-send-email-stigge@antcom.de>
 <20120227141430.GB3550@pengutronix.de> <4F4BA31F.8040201@antcom.de>
Message-ID: <20120227154848.GC3550@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I actually just ported this code from lpclinux.com and assumed that
> NXP knows best about LPC HW bugs. ;-)

Okay, if there is no errata ID, then that's also fine. Mentioning that
the fix comes from the official NXP-tree might be worth adding to the
comment, nonetheless. It feels much better if the hardware vendor
somehow confirms a hardware bug (be it just with code as in this case)
IMO.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/c4c86a0f/attachment.sig>
