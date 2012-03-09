From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 9 Mar 2012 14:26:28 +0100
Subject: [PATCH 0/3] introduce stmp-style devices
In-Reply-To: <201203081603.12817.arnd@arndb.de>
References: <1331159314-12022-1-git-send-email-w.sang@pengutronix.de>
 <201203081603.12817.arnd@arndb.de>
Message-ID: <20120309132628.GB2554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I think having the stmp_device code is good, but I'm not sure about the
> location in drivers/base, which is otherwise reserved for anything related
> to 'struct device'. How about putting the same file into lib/stmpregs.c?

Fine with me in general, except that I'd go for lib/stmp_device.c.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/f09d8161/attachment-0001.sig>
