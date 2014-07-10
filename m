From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 15:13:07 +0200
Subject: [PATCH 00/16] i2c: drop class based instantiaion for selected
 drivers
In-Reply-To: <20140710143837.558c1d07@ipc1.ka-ro>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
 <20140710143837.558c1d07@ipc1.ka-ro>
Message-ID: <20140710131307.GI2728@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	/* Warn that the adapter lost class based instantiation */
> > +	if (adapter->class == I2C_CLASS_DEPRECATED) {
> > +		dev_dbg(&adapter->dev,
> > +			"This adapter dropped support for I2C classes and "
> > +			"won't auto-detect %s devices anymore. If you need it, check "
> > +			"'Documentation/i2c/instantiating-devices' for alternatives.\n",
> >
> It's usually a bad idea to split kernel messages across source lines

Yes, "usually". Not for this message, though, it's specific. The lines
would have been quite long.

> You could at least do the split at the sentence boundary.

OK, this would have been a compromise.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/dcb5f312/attachment.sig>
