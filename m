From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Mar 2015 11:37:40 -0700
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Message-ID: <20150323183740.GI14954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 06:54:34PM +0100, Stefan Wahren wrote:
> > Sascha Hauer <s.hauer@pengutronix.de> hat am 23. M?rz 2015 um 07:07

> > It is very unusual to describe the regulators of a device on a register
> > level like this and to iomemap each register individually. I think you
> > should drop the registers here and put this knowledge into the driver
> > like (nearly?) all others do.

> do mean dropping the base address of the regulator, too?

> How would you implement it (bare register address or regmap or syscon), since
> there
> are overlapping register regions for different driver?

> @Mark: What's your opinion?

This might be the sort of thing normally handled by a system controller,
I have to say I had assumed this had all been discussed in the previous
iterations of this seriee.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/9c3f8374/attachment.sig>
