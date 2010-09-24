From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Sep 2010 17:30:36 -0700
Subject: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
In-Reply-To: <AANLkTimLL-vT-sspq8oTGotoKQhxS6en-+S5g0-HpYJ=@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<20100923172254.GM4211@atomide.com>
	<AANLkTimLL-vT-sspq8oTGotoKQhxS6en-+S5g0-HpYJ=@mail.gmail.com>
Message-ID: <20100924003035.GY4211@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100923 10:18]:
> On Thu, Sep 23, 2010 at 10:22 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100817 21:28]:
> >> This change adds in MMC and I2C support to the HTC Herald board, as well
> >> as adding the HTCPLD driver for the PLD used on this phone. ?It also
> >> adds in the gpio-keys entries for the front directional keys and
> >> selector and the cursor keys on the slide-out keyboard, and gpio-leds
> >> support for the LEDs attached to the htcpld.
> >>
> >> Additionally, SPI bus support (using the spi100k driver) and
> >> touchscreen support (using the ads7846 driver) were added.
> >
> > Thanks, I'll add this into omap-for-linus for the upcoming merge
> > window. Cory, can you please check if you have other pending
> > patches? I don't see others in patchwork.kernel.org, but thought
> > there may be some that did not get merged last merge window?
> >
> 
> I believe you have everything.  I had submitted a series of 5 patches
> that you commented on, and this one was the boiled down combination of
> all of those (minus one element which I'm still looking into).  So,
> just this one should be pending.

OK thanks.

Tony
