From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Aug 2012 11:55:55 +0200
Subject: MX28 & finding out boot mode
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C630EF@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20120830082518.GA27306@pengutronix.de>
 <20120830081215.GA1198@shlinux2.ap.freescale.net>
 <F281D0F91ED19E4D8E63A7504E8A649803C63005@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120830091318.GC27306@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C630EF@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120830095555.GE27306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 09:40:05AM +0000, Chen Peter-B29397 wrote:
>  
> > 
> > Some customers want this to handle the recovery case differently than
> > the standard case.
> > 
> 
> If you can't find method at datasheet (like reading some registers), a workaround

I hoped there was one bit in the persistent registers where the ROM
code stores such stuff. Sadly, those are usually not documented, so I
asked.

> is according to usb register, usually, usbcmd.rs (pull-up DP) stands for usb is using
> or not.

I think this is too much of a workaround for me :)

Thanks anyway!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120830/9a726b79/attachment.sig>
