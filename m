From: alexanders83@web.de (Alexander Stein)
Date: Sat, 12 Apr 2014 12:42:18 +0200
Subject: [PATCH 3/4] ALSA: sound/atmel/ac97c.c: Add device tree support
In-Reply-To: <1397298688.295112408@f331.i.mail.ru>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
 <1397293707-26890-4-git-send-email-alexanders83@web.de>
 <1397298688.295112408@f331.i.mail.ru>
Message-ID: <5369289.Xz059aMMT6@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 April 2014, 14:31:28 wrote Alexander Shiyan:
> Sat, 12 Apr 2014 11:08:26 +0200 ?? Alexander Stein <alexanders83@web.de>:
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> > ---
> >  .../devicetree/bindings/sound/atmel_ac97c.txt      | 20 +++++++++
> >  sound/atmel/ac97c.c                                | 52 ++++++++++++++++++++--
> >  2 files changed, 69 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/atmel_ac97c.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/atmel_ac97c.txt b/Documentation/devicetree/bindings/sound/atmel_ac97c.txt
> > new file mode 100644
> > index 0000000..9839403
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/atmel_ac97c.txt
> > @@ -0,0 +1,20 @@
> > +* Atmel AC97 controller
> > +
> > +Required properties:
> > +  - compatible: "atmel,atmel_ac97c"
> > +  - reg: Address and length of the register set for the device
> > +  - interrupts: Should contain AC97 interrupt
> > +  - atmel,reset-pin: GPIO for resetting the codec
> 
> Why standard "gpios" property cannot be used here?

I guess they can. I have no experience defining a devicetree binding, so I just stuck to the platformdata member name.
If this is the recommended way, I'll gladly change that.

Alexander
