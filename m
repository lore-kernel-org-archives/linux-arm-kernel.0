From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 20 Feb 2012 12:07:55 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <20120220113549.7f2a553e@eb-e6520>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
 <20120220113549.7f2a553e@eb-e6520>
Message-ID: <201202201207.55969.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Eric B?nard wrote:
> Le Mon, 20 Feb 2012 12:11:58 +0200,
>
> Baruch Siach <baruch@tkos.co.il> a ?crit :
> > On Mon, Feb 20, 2012 at 11:07:56AM +0100, joancarles wrote:
> >
> > [snip]
> >
> > > We are also trying a stock 3.3-rc kernel and can't get
> > > our i.MX25 to boot ... yet.
>
> 3.3-rc works fine here (at least it was until 2 weeks ago).
>
> I'll send you a dirty patch which works on 3.1 & 3.2 for the ADC.

Then we should share it, as I'm also working in the ADC/touchscreen/hwmon 
driver for i.MX25.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
