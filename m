From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 25 Feb 2015 08:20:00 -0800
Subject: [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
In-Reply-To: <20150225150459.GE17992@lunn.ch>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
 <20150223143416.GT1509@kw.sim.vm.gnt> <54EB3C84.30503@roeck-us.net>
 <20150225111430.GV1509@kw.sim.vm.gnt>
 <20150225135015.GA17992@lunn.ch> <54EDE171.7040403@roeck-us.net>
 <20150225150459.GE17992@lunn.ch>
Message-ID: <20150225162000.GA25241@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:04:59PM +0100, Andrew Lunn wrote:
> > However, we need to state and check in the code that _some_ property
> > is mandatory. A driver with only optional properties doesn't make
> > sense.
> 
> The patch to the binding documentation said:
> 
> Note: At least one the "gpios" and "alarm-gpios" properties should be set.
> 
> which i then suggested should be:
> 
> Note: At least one of "gpios" or "alarm-gpios" properties should be set.
> 
"should" is not "must".

Guenter

> What we could do is move this sentence into the Required Properties of
> the documentation.
> 
> The patch Simon submitted also does check that this condition is
> fulfilled.
> 
> 	Andrew
> 
> 
> 
