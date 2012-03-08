From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 8 Mar 2012 08:45:10 +0100
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <CAOMZO5C9EDi_Hy-8=iphr+154gyPgBLnjSVV0seLgi+HoK4zRw@mail.gmail.com>
References: <1331159314-12022-1-git-send-email-w.sang@pengutronix.de>
 <1331159314-12022-2-git-send-email-w.sang@pengutronix.de>
 <CAOMZO5C9EDi_Hy-8=iphr+154gyPgBLnjSVV0seLgi+HoK4zRw@mail.gmail.com>
Message-ID: <20120308074510.GB18510@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 07:40:22PM -0300, Fabio Estevam wrote:
> On Wed, Mar 7, 2012 at 7:28 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> ...
> > +static int stmp_clear_poll_bit(void __iomem *addr, u32 mask)
> > +{
> > + ? ? ? int timeout = 0x400;
> 
> Could you please add a proper timeout mechanism here?
> 
> Something like: http://patchwork.ozlabs.org/patch/137365/

>From the patch description:

===

To avoid regressions and ease reviewing, the actual code is simply copied from
mach-mxs. It definately wants updates, but those need a seperate patch series.

===

Or is that considered a wrong path?

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/cb794861/attachment.sig>
