From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 6 Sep 2011 11:10:16 +0200
Subject: [PATCH] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <20110906083926.GE28816@pengutronix.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<20110906083926.GE28816@pengutronix.de>
Message-ID: <20069.58232.365025.824697@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig writes:
> Hello Stefano,
> 
> On Mon, Aug 29, 2011 at 09:50:50AM +0200, Stefano Babic wrote:
> > Added initial support for DENX M28 module and M28EVK
> > board. Ethernet(FEC), SDHC, Display are supported.
> > 
> > Signed-off-by: Stefano Babic <sbabic@denx.de>
> All in all I like your patch, just a few minor issues below.
> 
When I tried to send a patch for new board support a few weeks ago I
was told that no more new boards files would be added due to upcoming
DTS support:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/057649.html
Has this policy changed since?
Should I resend my patch for the TX53?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
