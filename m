From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Tue, 24 Nov 2009 09:43:41 -0200
Subject: USB support on i.MX27
Message-ID: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

I am trying to add USB support to i.MX27 on mainline linux kernel, I
am following your modifications as in this post:

"Re: Comment to "[PATCH 7/8] Add EHCI support for MX27 and MX31 based boards"

I can't find xcvr.h and isp1504_xcvr.h then I copied fsl_xcvr.h from
FSL kernel to mainline:

alan at metropolis:~/ltib-patches/ltib/rpm/BUILD/linux$ cp
include/linux/usb/fsl_xcvr.h
~/linux/pengutronix/linux-2.6/include/linux/usb/xcvr.h

But I can't to figure out where to find isp1504_xcvr.h.

Could you please help me to get USB working on iMX27ADS?

Best Regards,

Alan
