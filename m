From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 13 Sep 2012 10:52:39 +0200
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <87wqzysuu3.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <20120912131615.GB16547@pengutronix.de>
 <87pq5quaqr.fsf@deeprootsystems.com>
 <87wqzysuu3.fsf@deeprootsystems.com>
Message-ID: <20120913085239.GA14237@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

> Since this series is already merged, I suggest that the problem patch be
> reverted, at least for v3.7 and until the problem is better understood
> and tested.

I thought I'll give you guys some more days to fix the problem before
reverting.

> 
> With that patch reverted, all my PM tests are passing.  Feel free to
> add:
> 
> Tested-by: Kevin Hilman <khilman@ti.com>

Thanks. That indeed increases confidence in this series. I won't add the
tags to the tree, though, since that would mean rebasing.

All the best,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/a775360b/attachment.sig>
