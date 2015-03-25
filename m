From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 25 Mar 2015 12:04:34 +0100
Subject: [PATCH v2] ARM: dts: imx25-pinfunc: Add several pinfunctions
In-Reply-To: <20150324200220.GW5664@pengutronix.de>
References: <1427206342-10672-1-git-send-email-mpa@pengutronix.de>
 <20150324200220.GW5664@pengutronix.de>
Message-ID: <20150325110434.GC5024@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 09:02:20PM +0100, Uwe Kleine-K?nig wrote:
> Hello Markus,
> 
> On Tue, Mar 24, 2015 at 03:12:22PM +0100, Markus Pargmann wrote:
> > +/* The imx25 RM appendix describes this mux as CAN1 which is wrong */
> > +#define MX25_PAD_FEC_RDATA1__CAN2_TX		0x1e0 0x3d8 0x000 0x14 0x000
> What about
> 
> 	/*
> 	 * According to the i.MX25 Reference manual (IMX25RM, Rev. 2,
> 	 * 01/2011) this is CAN1_TX but that's wrong.
> 	 */
> 
> ? It doesn't fit in a single line, but it's still reconstructable in
> case Freescale publishes a Rev 3 which is wrong in a different way :-)

Although I am not expecting a new revision of the reference manual it's
a good idea to state the reference manual revision in the comment.
Thanks, will fix that.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/188d7fcb/attachment.sig>
