From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Aug 2013 11:48:52 +0200
Subject: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3 2/2] i2c: imx:
 Add Vybrid VF610 I2C controller support
In-Reply-To: <20130813161214.GV26614@pengutronix.de>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
 <52096E77.4040003@wwwdotorg.org>
 <20130813074620.GR26614@pengutronix.de>
 <520A5558.708@wwwdotorg.org>
 <20130813161214.GV26614@pengutronix.de>
Message-ID: <20130815094850.GB2987@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I vote for having the exact SoC revision in the binding documentation
> rather than wildcards or references to the list of i.MX SoCs. Otherwise
> only the driver code gives a clue that the i2c driver matches imx1-i2c,
> imx21-i2c and vf610-i2c, but not imx31-i2c.

Dunno if I got all right, so adding my 2 cents:

Yes to adding each SoC to the binding docs. No to adding each SoC to the
driver as a seperate 'compatible' entry if not really needed to
distinguish IP versions. I mean imx31 should have two compatible entries
anyhow, one for imx31 and one for imx21 as fallback, no?

That all being said: Unless somebody objects, I'll pick the most recent
VF610 series today and leave the doc fixup for later.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/bc41abc3/attachment.sig>
