From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 May 2012 09:24:53 +0200
Subject: [PATCH 1/2] usb: fsl_mxc_udc.c: add workaround for ENGcm09152
 for i.MX25
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B91ED2@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1336461510-30190-1-git-send-email-eric@eukrea.com>
 <F281D0F91ED19E4D8E63A7504E8A649803B91ED2@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <20120509072453.GH27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 02:59:52AM +0000, Chen Peter-B29397 wrote:
>  
> > 
> > this patch gives the possibility to workaround bug ENGcm09152
> > on i.MX25 when the hardware workaround is also implemented on
> > the board.
> > It covers the workaround described on page 42 of the following Errata,
> > titled "USB: UTMI_USBPHY VBUS input impedance implementation error" :
> > http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf
> > 
> 
> The two patches are ok, I am not sure if sascha is ok for these two
> as there is cpu_is_xxx code although it is bug fix.

I am ok with these patches. I think we should try hard and merge the
drivers, but this shouldn't be a reason to block bug fixes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
