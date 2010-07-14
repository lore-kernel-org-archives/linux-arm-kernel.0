From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Wed, 14 Jul 2010 20:20:54 +0530
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100713203852.GA1756@rakim.wolfsonmicro.main>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
	<20100713141828.GB24260@rakim.wolfsonmicro.main>
	<33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
	<20100713145645.GA24626@rakim.wolfsonmicro.main>
	<20100713150814.GA13767@bnru01.bnr.st.com>
	<20100713150905.GD24626@rakim.wolfsonmicro.main>
	<20100713161343.GA25342@bnru01.bnr.st.com>
	<20100713203852.GA1756@rakim.wolfsonmicro.main>
Message-ID: <20100714145053.GA1689@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Thanks

> > +struct regulator_init_data ab8500_vaudio_init = {
> > +	.supply_regulator_dev = NULL,
> > +	.constraints = {
> > +		.name = "ab8500-vaudio",
> > +		.min_uV = 1925000,
> > +		.max_uV = 2075000,
> 
> Are you *sure* that all these constraints are accurate for the board?
As far as the min/max values of the voltage go, yes they are as per the
data sheet.

> It seems every single voltage is variable even though there are no
> consumers set up, and they can all be disabled too.
Yes. all these regulators can be disabled/enabled. does this answer your
qeury? ( or i didnt understand it properly??)

Thanks,
Sundar
