From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Jan 2013 17:44:03 +0100
Subject: [PATCH] i2c: samsung: resume race fix
In-Reply-To: <CALiw-2F7tG9ogDHj4Yf47T47rBn6mAiH2XvK8jpWB1a3OhNJBQ@mail.gmail.com>
References: <1352284106-24988-1-git-send-email-ch.naveen@samsung.com>
 <20121107114437.0a563c7e@endymion.delvare>
 <20130124132759.GH12933@pengutronix.de>
 <CALiw-2F7tG9ogDHj4Yf47T47rBn6mAiH2XvK8jpWB1a3OhNJBQ@mail.gmail.com>
Message-ID: <20130124164402.GC2603@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>    below setting suspended = 1. Upstream implementation of the same
>    functionality will be implemented differently, most likely.

Thanks, so I'll discard this patch.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/8dca191b/attachment.sig>
