From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 21 May 2011 12:21:02 +0100
Subject: [PATCH 0/4] Samsung: Move Samsung SoCs GPIO drivers to
	drivers/gpio
In-Reply-To: <20110520063128.GA21285@ponder.secretlab.ca>
References: <20110520054441.GA9952@july>
	<20110520063128.GA21285@ponder.secretlab.ca>
Message-ID: <20110521112102.GA11887@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 12:31:28AM -0600, Grant Likely wrote:
> On Fri, May 20, 2011 at 02:44:41PM +0900, Kyungmin Park wrote:
> >  .../gpiolib.c => drivers/gpio/s5pc100-gpio.c       |    0
> >  .../gpiolib.c => drivers/gpio/s5pv210-gpio.c       |    0
> >  .../gpiolib.c => drivers/gpio/samsung-gpiolib.c    |    3 +-

> drivers/gpio/gpio-*.c please.  I'm starting to enforce some level of
> naming convention.

Hrm, looking at the current mainline drivers the existing tendency seems
to be mostly towards gpio/*-gpio.c...
