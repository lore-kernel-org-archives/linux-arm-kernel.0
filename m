From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 29 Mar 2012 08:43:20 +0200
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <4F73CCC6.6000001@freescale.com>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <4F73CCC6.6000001@freescale.com>
Message-ID: <20120329064320.GA20840@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >  include/linux/stmp_device.h |   20 +++++++++++
> IMHO, this header should be placed at include/linux/fsl/.

Hmm, one never knows if somewhen in the future some other vendor decides to do
do a device with this register layout. It is just a layout, not an IP core per
se. So, I'd prefer to leave it as is.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/bac4e086/attachment.sig>
