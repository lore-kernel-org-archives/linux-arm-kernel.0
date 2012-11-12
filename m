From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun, 11 Nov 2012 17:12:58 -0800
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <CACRpkdZvHBjFQTrQnxvc3WCOb2CqGbjYJxyQ5qQkSbU+UWHYZA@mail.gmail.com>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <CACRpkdZvHBjFQTrQnxvc3WCOb2CqGbjYJxyQ5qQkSbU+UWHYZA@mail.gmail.com>
Message-ID: <20121112011258.GA23724@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 02:00:31AM +0100, Linus Walleij wrote:
> On Sun, Nov 11, 2012 at 5:21 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > From: Jamie Lentin <jm@lentin.co.uk>
> >
> > Given appropriate devicetree bindings, this driver registers a
> > pm_power_off function to set a GPIO line high/low to power down
> > your board.
> >
> > Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> So this is just a GPIO client like any such thing right?
> 
> I mean this thing has nothing more to do with the GPIO subsystem
> than say, drivers/input/keyboard/gpio_keys.c?
> 
> So from the GPIO subsystem point of view controlling power is
> an alien concept.
> 
> But I suspect Anton may be ready to welcome a driver like this
> under drivers/power/* which I think is where it belongs.

Yup. driver/power/reset/ seems appropriate.

Thanks,
Anton.
