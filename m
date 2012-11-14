From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 17:58:45 +0100
Subject: [PATCH 0/8] I2C patches for v3.8 merge window
In-Reply-To: <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <20121022133023.GC14033@arwen.pp.htv.fi>
 <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
Message-ID: <20121114165845.GB1020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> here's another series for OMAP I2C driver. There are a few cleanups
> >> and one very nice new feature: we can now report how many bytes
> >> we transferred until NACK.
> >>
> >> Note that the implemementation for OMAP-I2C turned out to be a
> >> little more complex then I expected, mainly because of the way
> >> I2C_CNT register behaves and because of the very buggy register
> >> usage on that driver.
> >>
> >> I have boot tested all patches on beagle xM (3630) and pandaboard
> >> rev A3 (4430), will send boot-logs if anyone wants to see.

The series is a bit confusing mixing V1, V2 and V3 patches. Also, there
are a few comments unaddressed it seems to me (reading in hot path,
barriers). Please make sure these are properly handled and resend as a
seperate series (all patches V4). Bonus point if you rebase it to my
for-next, which I will push out soon.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/abbaf878/attachment.sig>
