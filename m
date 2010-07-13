From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Tue, 13 Jul 2010 20:38:15 +0530
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100713145645.GA24626@rakim.wolfsonmicro.main>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
	<20100713141828.GB24260@rakim.wolfsonmicro.main>
	<33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
	<20100713145645.GA24626@rakim.wolfsonmicro.main>
Message-ID: <20100713150814.GA13767@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm pretty sure that people will be able to figure out how to add a
> consumer list by themselves when they need it, and the lists you're
> currently including are actively harmful in that they are encouraging
> people to hard code board specific supply names or start passing supply
> names around as platform data.
OK. so I include only regulator_init_data and keep the
regulator_consumer_supply empty. Is this the right thing forward?

Regards,
Sundar
