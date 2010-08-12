From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 12 Aug 2010 23:54:02 +0200
Subject: [rtc-linux] [PATCH] rtc: rtc-lpc32xx: Introduce RTC driver for
	the LPC32XX SoC (v2)
In-Reply-To: <20100812090727.GA6787@pengutronix.de>
References: <1281567980-12792-1-git-send-email-wellsk40@gmail.com>
	<1281567980-12792-2-git-send-email-wellsk40@gmail.com>
	<20100812090727.GA6787@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F80AC719C808@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +/*
> > + * Clock and Power control register offsets  */
> > +#define RTC_UCOUNT		0x00
> > +#define RTC_DCOUNT		0x04
> > +#define RTC_MATCH0		0x08
> > +#define RTC_MATCH1		0x0C
> > +#define RTC_CTRL		0x10
> > +#define RTC_INTSTAT		0x14
> > +#define RTC_KEY			0x18
> > +#define RTC_SRAM		0x80
> 
> How about LPC32XX_-prefixes here?
> 

Hi Wolfram,

This and all following items are updated in v3

thanks,
Kevin
