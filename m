From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Apr 2012 09:28:11 +0200
Subject: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <4F90812F.5090106@antcom.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de>
 <20120419160715.GD24987@pengutronix.de>
 <4F903E0C.6010604@antcom.de>
 <20120419203915.GB28005@pengutronix.de>
 <4F90812F.5090106@antcom.de>
Message-ID: <20120420072811.GA9769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Another solution would be to not use timeout with the dt enabled
> i2c-pnx for now (using the hard coded default timeout as the current
> i2c-pnx.c does) and possibly introduce the (anyway optional) "timeout"
> later.

Yeah, let's do it like this.

> Interesting! When the documentation is outdated - how does the parser
> actually decide between hex (e.g. regs/addresses) and dec (e.g.
> clock-frequency) in the absence of "0x"?

Are there regs without 0x?

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/40b6643a/attachment.sig>
