From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 May 2014 20:13:13 -0700
Subject: [GIT PULL] Versatile LEDs conversion
In-Reply-To: <CACRpkdaAVMf1t03jRZFa2qbTDnJZB2XBvOaeWBgwTSqvfLo2Aw@mail.gmail.com>
References: <CACRpkdb4VhN5Dt6ZoUNgwphxUD7Q69waF9vfO_=SenbvA=WSeA@mail.gmail.com>
 <20140505041156.GB11035@quad.lixom.net>
 <201405061458.22231.arnd@arndb.de>
 <CACRpkdaAVMf1t03jRZFa2qbTDnJZB2XBvOaeWBgwTSqvfLo2Aw@mail.gmail.com>
Message-ID: <20140511031313.GA22931@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 06:09:52AM -0700, Linus Walleij wrote:
> On Tue, May 6, 2014 at 5:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I got a build error today, since LEDS_VERSATILE can be built-in while LEDS_CLASS
> > is a module:
> >
> > drivers/built-in.o: In function `versatile_leds_probe':
> > :(.text+0x155020): undefined reference to `led_classdev_register'
> >
> > I suggest we turn this option into 'tristate' so that the dependency
> > tracking works correctly.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Quite tricky these bool/tristate things :-/
> 

Applied onto next/cleanup.


-Olof
