From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Sep 2018 09:27:46 +0200
Subject: [PATCH] ARM: dts: realview: Fix SPI controller node names
In-Reply-To: <CAL_JsqJ9FMK1d24Fc-JTFh6sPn2svCUQx29UNLMzchDQJr5svA@mail.gmail.com>
References: <20180913181245.25484-2-robh@kernel.org>
 <CAL_JsqJ9FMK1d24Fc-JTFh6sPn2svCUQx29UNLMzchDQJr5svA@mail.gmail.com>
Message-ID: <CACRpkdYY4aVJLEM3wE9_GPnnBg9S4StuQNt_4TDZHOMUQk4w8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 1:15 AM Rob Herring <robh@kernel.org> wrote:
> On Thu, Sep 13, 2018 at 1:12 PM Rob Herring <robh@kernel.org> wrote:
> >
> > SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> > name enables dtc SPI bus checks.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please apply to the sub-arch tree. The dtc changes haven't landed, but
> > will for 4.20.
>
> Ping.
>
> Arnd, Olof, Can you pick this up if the sub-arch maintainer doesn't.

Sorry I'll pick it up and also send the patch listing myself as
subarch maintainer that got mysteriously lost as well. :/

Yours,
Linus Walleij
