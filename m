From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Jan 2013 15:44:01 +0000
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <201301071613.33573.marex@denx.de>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130107150341.GT21994@gmail.com>
 <201301071613.33573.marex@denx.de>
Message-ID: <20130107154401.GW21994@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +	pdata->irq_over_gpio = of_get_property(np, "irq-over-gpio", NULL);
> > 
> > This is a new DT binding and you haven't provided any documentation for it.
> > 
> > Also, there is no reason for the binding to exist.
> > 
> > Lots of drivers use GPIO pins as IRQs.
> 
> Right, this can be removed and only the 'irq-gpios' can be kept around. What do 
> you say?

I don't like it to be honest.

How many GPIOs does the STMPE driver need?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
