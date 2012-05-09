From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 9 May 2012 10:19:10 +0000
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201205091043.39787.marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205031527.16149.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B91EFD@039-SN2MPN1-022.039d.mgd.msft.net>
 <201205091043.39787.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B93343@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> Good, any other problems you noticed?
> 
- Can you change the name from include/linux/usb/mxs-usb.h to imx-usb.h
as it will be used for other i.mx platforms.
- For drivers/usb/gadget/ci13xxx_udc.c change, 
can you add alexander.shishkin at linux.intel.com to review 

> Thanks!
> 
> Best regards,
> Marek Vasut
