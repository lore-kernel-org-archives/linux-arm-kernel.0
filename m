From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 17:35:13 +0100
Subject: [PATCH] mfd: mc13xxx: add I2C support fix building for v3.4
In-Reply-To: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD25@MEP-EXCH.meprolight.com>
References: <1332943273-22447-1-git-send-email-alexg@meprolight.com>
 <20120328144017.GV3232@opensource.wolfsonmicro.com>
 <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD25@MEP-EXCH.meprolight.com>
Message-ID: <20120328163512.GB3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 06:31:04PM +0200, Alex Gershgorin wrote:
> On Wed, Mar 28, 2012 at 04:01:13PM +0200, Alex Gershgorin wrote:

> > +     select REGMAP_I2C if I2C
> > +     select REGMAP_SPI if SPI_MASTER

> > > I'd really expect this to be squashed into the patches adding the regmap
> > > usage for I2C and SPI, how can those patches work without this?

> You ask me about another solution?

I'm saying either I'm missing something or this needs to be fixed in the
patches that introduce the regmap usage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/6b5ebf67/attachment.sig>
