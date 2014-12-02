From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 2 Dec 2014 14:21:59 +0100
Subject: [PATCH 1/3] staging: imx-drm: document internal HDMI I2C master
 controller DT binding
In-Reply-To: <547DBA99.1010703@mentor.com>
References: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1416073759-19939-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <547C8113.3050100@mentor.com>
 <1417446703.4624.18.camel@pengutronix.de>
 <547C8B9E.8050605@mentor.com>
 <1417450979.4624.23.camel@pengutronix.de>
 <547D5DE2.2040704@rock-chips.com> <547DBA99.1010703@mentor.com>
Message-ID: <20141202132158.GD4072@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Thank you for references.

Yes, thank you all. Really great to see this consolidation effort going
on!

> I'll try to review all out of i2c/busses/* registered i2c adapters, may
> be there is something in common between all of them.

Yay, cool! Thanks!

> I'll prepare the change of the HDMI DDC support for review (will be able
> to test it only on iMX6), Wolfram, please skip from your consideration
> the published version of the i2c bus driver.

Okay, will do.

> Wolfram, by the way is I2C_CLASS_DDC adapter class in operational use or
> deprecated?

Class based instantiation is NOT deprecated and will stay as far as I
can see. Many platform bus drivers did set the class flag needlessly, so
we had a deprecation mechanism to get rid of those flags in drivers in
order to speed up boot time.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/32141fca/attachment-0001.sig>
