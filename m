From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 09:30:32 +0200
Subject: [PATCH 1/3] gpio-twl4030: get platform data from device tree
In-Reply-To: <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
 <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <CACRpkdY7AtvGRabo6A9Go=g1=nJY08YXGm3r5oL+Q9RKjW=Ncw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 3:54 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:

> Adds a number of missing properties to the device tree of
> twl4030/gpio:
> - "ti,use-leds"  -> .use_leds
> - "ti,debounce"  -> .debounce
> - "ti,mmc-cd"    -> .mmc_cd
> - "ti,pullups"   -> .pullups
> - "ti,pulldowns" -> .pulldowns
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Tony will you carry this in the OMAP tree?

Yours,
Linus Walleij
