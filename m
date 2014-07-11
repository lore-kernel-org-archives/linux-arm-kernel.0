From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 11 Jul 2014 10:38:31 +0200
Subject: [PATCH] i2c: efm32: correct namespacing of location property
In-Reply-To: <20140711082826.GJ11056@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
 <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140711082826.GJ11056@pengutronix.de>
Message-ID: <20140711083831.GB2786@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	if (!ret)
> This must be "if (ret)". I noticed during testing but obviously forgot
> to fixup before sending out. Should I resend?

Yup.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/a5410753/attachment.sig>
