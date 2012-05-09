From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 9 May 2012 02:59:52 +0000
Subject: [PATCH 1/2] usb: fsl_mxc_udc.c: add workaround for ENGcm09152
 for i.MX25
In-Reply-To: <1336461510-30190-1-git-send-email-eric@eukrea.com>
References: <1336461510-30190-1-git-send-email-eric@eukrea.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B91ED2@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX25 when the hardware workaround is also implemented on
> the board.
> It covers the workaround described on page 42 of the following Errata,
> titled "USB: UTMI_USBPHY VBUS input impedance implementation error" :
> http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf
> 

The two patches are ok, I am not sure if sascha is ok for these two
as there is cpu_is_xxx code although it is bug fix.

 
