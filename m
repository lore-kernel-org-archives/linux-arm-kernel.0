From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 14 Sep 2012 13:32:12 +0200
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
In-Reply-To: <20120914101542.GT3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
 <20120914090228.GH3374@gmail.com>
 <20120914093945.GB2630@pengutronix.de>
 <20120914101542.GT3374@gmail.com>
Message-ID: <20120914113212.GD2630@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > 	Documentation: Device Tree binding information for i2c-nomadik driver
> > 		(Documentation should go along with the code)
> 
> I'm still not too sure about how this benefits anyone. You can ensure
> the documentation is placed in an adjacent patch, so it's just as easy
> to make reference to.

It makes reviewing a lot easier if the documentation what is supposed to
be coded and the actual code are in one place. It also prevents what
happened in this case where the documentation never showed up on the
i2c-list.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120914/d805435b/attachment.sig>
