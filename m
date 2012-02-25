From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 25 Feb 2012 04:51:28 +0100
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <201202241503.27406.arnd@arndb.de>
References: <1330030639-3796-1-git-send-email-stigge@antcom.de>
 <4F46AA06.30502@antcom.de> <20120224063521.GA16412@pengutronix.de>
 <201202241503.27406.arnd@arndb.de>
Message-ID: <20120225035128.GA4455@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I would recomment telling this from the device itself rather than from the
> platform.

Basically yes...

> Unfortunately, the way that ohci handles the abstraction between the
> various implementations is backwards, it would be much easier if the
> main driver was following that model to start with.

... exactly for that reason I didn't suggest it. Looking at other ohci-sources
(e.g. ohci-omap.c), machine_is_* seems to be the consistent use-case.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120225/4e25fede/attachment.sig>
