From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Mon, 25 Aug 2014 07:32:01 +0000
Subject: [PATCH] watchdog: imx2_wdt: Remove seperate big endian handling
In-Reply-To: <20140825072455.GB11914@pengutronix.de>
References: <1408949015-28759-1-git-send-email-mpa@pengutronix.de>
 <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140825070550.GA11914@pengutronix.de>
 <5d35f7c722e14022ba7db0221b9cfdb1@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140825072455.GB11914@pengutronix.de>
Message-ID: <1324d9d0fe3b4f43b6b18eb782c1bc3f@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > "watchdog: imx2_wdt: Convert to use regmap framework's endianness
> method."
> > >
> > > Thanks didn't see this one.
> > >
> > > Best regards,
> > >
> > > Markus
> > >
> >
> > I also hoping for your comments about it if there has any problem.
> 
> I just noticed that you added an include of of_address.h in your
> original patch:
> f728f4bfc495 (watchdog: imx2_wdt: adds big endianness support.)
> 
> But you don't remove the include in your current patch. Was the include
> missing in the driver?
> 

No, 

Well, if it does matter here, I will send another version to remove this.


Thanks,

BRs
Xiubo
