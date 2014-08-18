From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Aug 2014 09:03:06 +0200
Subject: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <20140816165316.GB2858@katana>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <20140816165316.GB2858@katana>
Message-ID: <20140818070306.GB12930@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 16, 2014 at 11:53:18AM -0500, Wolfram Sang wrote:
> 
> > +	mac_addr[5] = (macid_lo >> 8) & 0xff;
> > +	mac_addr[4] = macid_lo & 0xff;
> > +	mac_addr[3] = (macid_hi >> 24) & 0xff;
> > +	mac_addr[2] = (macid_hi >> 16) & 0xff;
> > +	mac_addr[1] = (macid_hi >> 8) & 0xff;
> > +	mac_addr[0] = macid_hi & 0xff;
> 
> That looks twisted, but I assume that you tested it is correct.

The registers are twisted that way.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/8d653ce7/attachment.sig>
