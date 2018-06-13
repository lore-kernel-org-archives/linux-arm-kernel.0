From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 13 Jun 2018 11:25:22 +0200
Subject: [PATCH 3/3] rtc: ftrtc010: let the core handle range
In-Reply-To: <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
 <20180604141528.15635-3-alexandre.belloni@bootlin.com>
 <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
Message-ID: <20180613092522.GS10521@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2018 11:10:35+0200, Linus Walleij wrote:
> On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > The current range handling is highly suspicious. Anyway, let the core
> > handle it.
> 
> Hmmm. I have datasheets, do you need some input about the hardware?
> Something I should patch?
> 

Nothing to do as you seemed to confirm what I did was OK. I could find
why it was set to 2148 in the first place. Maybe it correspond to the
default days, hours minutes, second values on the SoC.

> > The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
