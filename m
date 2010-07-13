From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 15:57:28 +0100
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B1810E7E880@EXDCVYMBSTM006.EQ1STM.local>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<20100713141709.GA24260@rakim.wolfsonmicro.main>
	<33A307AF30D7BF4F811B1568FE7A9B1810E7E880@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20100713145727.GB24626@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 04:34:56PM +0200, Sundar R IYER wrote:

> >> + * @mask: mask to enable/disable regulator
> >> + * @enable: bits to enable the regulator in normal(high power) mode
> >Have you addressed my comments here?
> Sorry that I couldn't inline my replies into the patch itself :(. I changed the comments for the variable
> from the previous patch set. But I agree I messed up!

> Yes. The mask here is different for the fact that we have two enable bits; enable LP(low power)
> mode and enable HP(high power). We enable only the HP modes and hence the different mask
> for enable/disable as well as for the enable.

OK.
