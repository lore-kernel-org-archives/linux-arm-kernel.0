From: ian@opensource.wolfsonmicro.com (Ian Lartey)
Date: Thu, 23 Sep 2010 16:16:01 +0100
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX32
	ADS board
In-Reply-To: <260783.23687.qm@web51006.mail.re2.yahoo.com>
References: <260783.23687.qm@web51006.mail.re2.yahoo.com>
Message-ID: <1285254961.1864.14.camel@Tapajos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-23 at 08:07 -0700, Fabio Estevam wrote:
> Ian,
> 
> --- On Thu, 9/23/10, Ian Lartey <ian@opensource.wolfsonmicro.com> wrote:
> 
> > From: Ian Lartey <ian@opensource.wolfsonmicro.com>
> > Subject: [PATCH] Fixing ethernet driver compilation error for i.MX32 ADS board
> > To: "Sascha Hauer" <kernel@pengutronix.de>, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>
> > Cc: "Wolfson Patches" <patches@opensource.wolfsonmicro.com>
> > Date: Thursday, September 23, 2010, 11:38 AM
> > Revert "ARM: mx3/mx31ads: fold board
> > header in its only user"
> > 
> > This reverts commit
> > ccfa7c269843001077df02d98918c6c9bde91395.
> > As the board header is also used cs89x0 ethernet driver by
> > the i.MX32 ADS.
> 
> Please change i.MX32 to i.MX31 in both the subject and commit message.

Will do, thanks for catching the error.
> 
> Regards,
> 
> Fabio Estevam
> 
> 

>       
Regards,
         Ian.
