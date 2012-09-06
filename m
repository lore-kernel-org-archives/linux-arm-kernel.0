From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 13:47:44 -0700
Subject: [PATCH 1/3] gpio-twl4030: get platform data from device tree
In-Reply-To: <CACRpkdY7AtvGRabo6A9Go=g1=nJY08YXGm3r5oL+Q9RKjW=Ncw@mail.gmail.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
 <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
 <CACRpkdY7AtvGRabo6A9Go=g1=nJY08YXGm3r5oL+Q9RKjW=Ncw@mail.gmail.com>
Message-ID: <20120906204744.GK1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120904 00:31]:
> On Mon, Sep 3, 2012 at 3:54 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
> 
> > Adds a number of missing properties to the device tree of
> > twl4030/gpio:
> > - "ti,use-leds"  -> .use_leds
> > - "ti,debounce"  -> .debounce
> > - "ti,mmc-cd"    -> .mmc_cd
> > - "ti,pullups"   -> .pullups
> > - "ti,pulldowns" -> .pulldowns
> >
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Tony will you carry this in the OMAP tree?

Yes thanks I can queue this once the acks are there,
I guess Benoit is planning to test the series first.

Regards,

Tony
