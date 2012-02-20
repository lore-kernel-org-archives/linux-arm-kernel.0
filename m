From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Mon, 20 Feb 2012 11:35:49 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <20120220101157.GB9921@sapphire.tkos.co.il>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
 <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
Message-ID: <20120220113549.7f2a553e@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joan,

Le Mon, 20 Feb 2012 12:11:58 +0200,
Baruch Siach <baruch@tkos.co.il> a ?crit :
> On Mon, Feb 20, 2012 at 11:07:56AM +0100, joancarles wrote:
> 
> [snip]
> 
> > We are also trying a stock 3.3-rc kernel and can't get
> > our i.MX25 to boot ... yet.
> 
3.3-rc works fine here (at least it was until 2 weeks ago).

I'll send you a dirty patch which works on 3.1 & 3.2 for the ADC.

Eric
-- 
http://eukrea.com/en/news/104-2012
