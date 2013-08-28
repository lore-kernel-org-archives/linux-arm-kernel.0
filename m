From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Aug 2013 22:43:13 +0200
Subject: [PATCH] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
In-Reply-To: <20130828195054.GJ8607@quad.lixom.net>
References: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130815084259.GG30496@pengutronix.de>
 <20130828195054.GJ8607@quad.lixom.net>
Message-ID: <20130828204313.GE24802@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I already told Olof via irc, but for the protocol:

On Wed, Aug 28, 2013 at 12:50:54PM -0700, Olof Johansson wrote:
> On Thu, Aug 15, 2013 at 10:42:59AM +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > I forgot to mention that this patch depends on the following patches:
> > 
> >  - ARM: ARMv7-M: implement restart routine common to all v7-M machines
> >    sent with Message-Id: 1376494305-24270-1-git-send-email-u.kleine-koenig at pengutronix.de; and
> 
> Seems like you addressed Russell's comments here, so hopefully he's ok with us
> picking it up directly as a prereq.
It was Jonathan Austin who commented, but anyhow as I don't think to get
all three patches ready in time for 3.12-rc1 I posted that one to
Russell's patch tracker.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
