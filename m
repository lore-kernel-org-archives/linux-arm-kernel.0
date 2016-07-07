From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 10:30:29 +0200
Subject: [PATCH 2/4] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <HE1PR04MB0889646206BFAD68046F3473F83B0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1465609853.22191.151.camel@buserror.net>
 <HE1PR04MB0889646206BFAD68046F3473F83B0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Message-ID: <4094106.qfxJu3tJbO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 2:35:33 AM CEST Yangbo Lu wrote:
> Hi Arnd,
> 
> Could you reply when you see the email?
> If your method doesn?t resolve the problem, we still want to use our old patchset.
> 
> This guts driver had been discussed about one year and blocked many workaround upstream.
> So please help to review and comment soon.
> 

I don't really see how more discussion is going to help us here. I think
I've made it pretty clear that I don't want to see another platform
specific way to read an SoC revision and I've even sent a proof-of-concept
patch to show how the interface can work, now it's up to you to fit the
guts hardware into that and send a new patch series.

	Arnd
