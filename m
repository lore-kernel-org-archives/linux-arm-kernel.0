From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Feb 2014 10:08:47 +0000
Subject: [linux-sunxi] Re: [PATCH 1/3] mfd: axp20x: Add mfd driver for
 axp20x PMIC
In-Reply-To: <CAOQ7t2ZWneDDrqpBQTWpmUozK8Pu4Ri97FX4E2R9NK72XECtaw@mail.gmail.com>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-2-git-send-email-carlo@caione.org>
 <20140210211900.GC32042@lee--X1>
 <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
 <20140211091505.GE32042@lee--X1>
 <CAOQ7t2ZWneDDrqpBQTWpmUozK8Pu4Ri97FX4E2R9NK72XECtaw@mail.gmail.com>
Message-ID: <20140211100847.GN32042@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> >> +     axp20x->i2c_client = i2c;
> >> >> +     i2c_set_clientdata(i2c, axp20x);
> >> >> +
> >> >> +     axp20x->dev = &i2c->dev;
> >> >> +     dev_set_drvdata(axp20x->dev, axp20x);
> >> >
> >> > Do you make use of all this saving of the device container?
> >> >
> >> > If so, where?
> >>
> >> In the drivers for subsystems (input, regulators, gpio, etc..)
> >
> > Can you link me to the patches please?  Any reason why they're not in
> > this set?  By submitting them together you give the Maintainers a good
> > over-view on how the system works together.
> 
> I wasn't sure it was a good idea to submit all the drivers altogether,
> so my idea was to submit one driver at a time.
> Do you think is it better to submit all the subsystems in one patch-set?

Normally.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
