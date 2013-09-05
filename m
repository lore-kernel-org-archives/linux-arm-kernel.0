From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Thu, 5 Sep 2013 09:13:13 +0200
Subject: [PATCH 2/5] Staging/iio/adc/touchscreen/MXS: separate i.MX28
 specific register bits
In-Reply-To: <20130904143624.GI6329@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
 <20130904143624.GI6329@mwanda>
Message-ID: <201309050913.13349.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Wednesday 04 September 2013 16:36:24 Dan Carpenter wrote:
> On Wed, Sep 04, 2013 at 03:01:43PM +0200, Juergen Beisert wrote:
> > +#define	LRADC_CTRL0_MX28_PLATE_MASK \
> > +		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> > +		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> > +		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW
>
> Put parenthesis are this macro.

Good catch. Thanks.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
