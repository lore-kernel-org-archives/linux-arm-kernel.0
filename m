From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Aug 2012 11:13:18 +0200
Subject: MX28 & finding out boot mode
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C63005@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20120830082518.GA27306@pengutronix.de>
 <20120830081215.GA1198@shlinux2.ap.freescale.net>
 <F281D0F91ED19E4D8E63A7504E8A649803C63005@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120830091318.GC27306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 08:47:21AM +0000, Chen Peter-B29397 wrote:
>  
> > > is there a way to find out how the MX28 was booted? I could read out
> > the
> > > bootmode-pins for indication. Still, either by button or by empty NAND,
> > > the CPU could have been booted via USB recovery mode. And going through
> > > the docs and the bootlets code, I can't find a way to determine if USB
> > > recovery was used.
> > >
> > > So, can USB recovery mode be detected somehow? Then, this and reading
> > > pins should be sufficent, no?
> > >
> > Add Frank&Peter who may know it.

Thanks.

> As far as I know, the romcode decides which mode is used, I haven't read
> romcode, so don't know priority of below booting selection.

For me, this is not about priorities, I just want to know which mode was
really used in the end :)

> Why do you need to know USB recovery mode at your code? 

Some customers want this to handle the recovery case differently than
the standard case.

Thanks for the help!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120830/43724dbe/attachment.sig>
