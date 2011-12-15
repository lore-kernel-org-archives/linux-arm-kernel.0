From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Dec 2011 05:48:38 +0000
Subject: [RFC PATCH v2 2/4] pinctrl: imx: add pinmux imx driver
In-Reply-To: <CAOMZO5DVsk_iNCrMaBbK4kuehhL1C71fKqC65isybJDknzWrRQ@mail.gmail.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-3-git-send-email-b29396@freescale.com>
 <CAOMZO5DVsk_iNCrMaBbK4kuehhL1C71fKqC65isybJDknzWrRQ@mail.gmail.com>
Message-ID: <7FE21149F4667147B645348EC6057885052C1B@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, December 15, 2011 12:01 AM
> To: Dong Aisheng-B29396
> Cc: linux-kernel at vger.kernel.org; linus.walleij at stericsson.com;
> s.hauer at pengutronix.de; rob.herring at calxeda.com;
> grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; Guo Shawn-R65073
> Subject: Re: [RFC PATCH v2 2/4] pinctrl: imx: add pinmux imx driver
> Importance: High
> 
> On Wed, Dec 14, 2011 at 2:03 PM, Dong Aisheng <b29396@freescale.com>
> wrote:
> 
> > +config PINMUX_IMX53
> > + ? ? ? bool "IMX53 pinmux driver"
> > + ? ? ? depends on ARCH_MX5
> 
> Shouldn't this be SOC_IMX53 instead?
> 
Yes, it should be SOC_IMX53.
Thanks.

Regards
Dong Aisheng
