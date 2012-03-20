From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 20 Mar 2012 08:50:59 +0100
Subject: [PATCH 1/1] net: phylib: remove the length limitation of mii
 bus id
In-Reply-To: <1332217679-3703-1-git-send-email-b29396@freescale.com>
References: <1332217679-3703-1-git-send-email-b29396@freescale.com>
Message-ID: <20120320075059.GA3849@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aisheng,

> So changed to remove the bus id length limitation, a lot of handwork.

You might want to try 'coccinelle' [1] next time. This is a tool exactly for
such kind of work. Already some basic knowledge can help you for a
number of tasks.

Regards,

   Wolfram

[1] http://en.wikipedia.org/wiki/Coccinelle_%28software%29

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/ae6ddc62/attachment.sig>
