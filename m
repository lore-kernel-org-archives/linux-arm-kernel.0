From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 09:19:05 +0300
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
	<87y62ng3f8.fsf@ti.com>
	<BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
Message-ID: <20110504061905.GD27860@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [110504 00:37]:
> 2011/5/3 Kevin Hilman <khilman@ti.com>:
> 
> > Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
> > into drivers/gpio first, followed by the cleanup/restructure patches?
> 
> In my case I actually did some cleanup after moving the driver for
> U300, but I think this is a question to the GPIO maintainer who
> I want to ACK this stuff in the end.
> 
> Grant?
> 
> You can always squash it later ...

Personally I would prefer absolutely minimal clean-up of current
code before moving to drivers/gpio to cut down the "crazy churn" in
arch/arm/. Also then further changes are easier for the GPIO
maintainers to review.

Of course I understand that this might cause extra load for the
GPIO maintainers, so it's up to the GPIO maintainers to set the
required standards before accepting the code into drivers/gpio.

Regards,

Tony
