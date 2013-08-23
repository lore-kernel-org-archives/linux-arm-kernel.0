From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Aug 2013 20:11:44 +0200
Subject: [PATCH v7] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
In-Reply-To: <20130823170411.GE7015@e106331-lin.cambridge.arm.com>
References: <1377243174-15877-1-git-send-email-gregory.clement@free-electrons.com>
 <20130823170411.GE7015@e106331-lin.cambridge.arm.com>
Message-ID: <20130823181143.GA3037@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	i2c at 11000 {
> > +		compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>                                          ^ That '8' shouldn't be there.

Oops, well, precisely the '8' is missing above. Fixed it, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/1dc1eaa9/attachment-0001.sig>
