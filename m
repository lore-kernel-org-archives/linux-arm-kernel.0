From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 7 Jul 2015 15:43:07 +0200
Subject: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
In-Reply-To: <1436276269.3344.94.camel@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de> <5476085B.40009@ti.com>
 <1436276269.3344.94.camel@pengutronix.de>
Message-ID: <20150707134307.GB3411@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I only stumbled across this after it was merged, with the additional
> ti,has-pfunc property instead of using the compatible string (which
> would be better for a soc-dependent feature). Can we still fix this?

Makes sense to me.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150707/2e347c33/attachment.sig>
