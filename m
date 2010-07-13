From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 16:09:06 +0100
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100713150814.GA13767@bnru01.bnr.st.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
	<20100713141828.GB24260@rakim.wolfsonmicro.main>
	<33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
	<20100713145645.GA24626@rakim.wolfsonmicro.main>
	<20100713150814.GA13767@bnru01.bnr.st.com>
Message-ID: <20100713150905.GD24626@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 08:38:15PM +0530, Sundar R IYER wrote:

> OK. so I include only regulator_init_data and keep the
> regulator_consumer_supply empty. Is this the right thing forward?

Yes, if you don't have any actual devices to supply.
