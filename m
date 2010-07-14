From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Wed, 14 Jul 2010 21:06:44 +0530
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100714145748.GF31073@rakim.wolfsonmicro.main>
References: <1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
	<20100713141828.GB24260@rakim.wolfsonmicro.main>
	<33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
	<20100713145645.GA24626@rakim.wolfsonmicro.main>
	<20100713150814.GA13767@bnru01.bnr.st.com>
	<20100713150905.GD24626@rakim.wolfsonmicro.main>
	<20100713161343.GA25342@bnru01.bnr.st.com>
	<20100713203852.GA1756@rakim.wolfsonmicro.main>
	<20100714145053.GA1689@bnru01.bnr.st.com>
	<20100714145748.GF31073@rakim.wolfsonmicro.main>
Message-ID: <20100714153643.GB1689@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Which datasheet, and will the system design actually be varying them at
> runtime - if it will how will it do so?  This is the settings for the
> particular system and generally a lot of these rails will get fixed at
> design time for various reasons (for example, the analogue supplies will
> usually depend on the analogue system design).
I am referring to the AB8500 device data sheet; not sure if its
available open.  I have taken the minimal/maximum figures as what is
mentioned for each supplies.

> Again, is it really the case that this will happen in this system?
Yes, if you are referring to regulator enable/disable.

> Nothing is currently able to actually do that, and unless every consumer
> using a given supply is hooked into the regulator API things will go
> wrong when some of them start doing so.
As i said earlier, my intention is to hard code the machine constraints.
The actual control in terms of enable/disable, controlling supply
voltages will happen, as you say when consumers are hooked up.

Thanks,
Sundar
