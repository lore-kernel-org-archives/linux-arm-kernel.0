From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 13 Nov 2012 08:58:13 +0100
Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A1C3952@SHSMSX101.ccr.corp.intel.com>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <20121112172651.GC15159@pengutronix.de>
 <27240C0AC20F114CBF8149A2696CBE4A1C3952@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20121113075813.GA23119@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Thanks your pointing out. I just manually reviewed the code when found
> this point. Would like to try some auto-script but failed:)

I can suggest 'coccinelle' for that kind of job.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/65f95058/attachment.sig>
