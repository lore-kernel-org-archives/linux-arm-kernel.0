From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Dec 2009 12:20:43 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <eedb5540911300815u5cf60634jd58918f454269028@mail.gmail.com>
References: <1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
	<20091130121017.GN27548@pengutronix.de>
	<eedb5540911300425n374af9f0k5346d85fdb79eb11@mail.gmail.com>
	<20091130123412.GP27548@pengutronix.de>
	<eedb5540911300509t11cc783cr8e97eda66ee382a@mail.gmail.com>
	<20091130160356.GT27548@pengutronix.de>
	<eedb5540911300815u5cf60634jd58918f454269028@mail.gmail.com>
Message-ID: <20091202112043.GA15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 05:15:45PM +0100, javier Martin wrote:
> 
> Sascha,
> there are actually two holes, with this current patch, PPCR3 still receives
> a wrong value:
> 
> 0x1001_6000 (HPCR1)
> 0x1001_6004 (HPCR2)
> 0x1001_6008 (HPCR3)
> 0x1001_600C (hole)
> 0x1001_6010 (PPCR1)
> 0x1001_6014 (PPCR2)
> 0x1001_6018 (hole)
> 0x1001_601C (PPCR3)


Lets hope I had enough sleep this night...

Sascha
