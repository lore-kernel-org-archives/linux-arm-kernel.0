From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 9 Mar 2011 09:26:01 +0100
Subject: [PATCH] net/fec: check id_entry pointer before using it
In-Reply-To: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
References: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110309082601.GA3145@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 10:50:04AM +0800, Jason Liu wrote:
> The id_entry will possibly be NULL, So, need check
> id_entry and make sure it not NULL before using it.

When does it become NULL?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110309/7a8fd09f/attachment.sig>
