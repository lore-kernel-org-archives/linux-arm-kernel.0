From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Jan 2014 15:57:19 +0000
Subject: [RFC 03/18] GPIO: gpio-generic: Add label to platform data
In-Reply-To: <CACRpkdb4w26vuOtR1bAhQ6k=1uQx=np4WwoabvH8pOq8HK54=w@mail.gmail.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-4-git-send-email-pawel.moll@arm.com>
 <CACRpkdb4w26vuOtR1bAhQ6k=1uQx=np4WwoabvH8pOq8HK54=w@mail.gmail.com>
Message-ID: <1389196639.23721.16.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings (and the usual: Happy New Year!)

On Mon, 2013-12-23 at 17:26 +0000, Linus Walleij wrote:
> On Mon, Dec 23, 2013 at 5:23 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > When registering more than one platform device, it is
> > useful to set the gpio chip label in the platform data.
> >
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > Cc: Anton Vorontsov <anton@enomsg.org>
> 
> Good point. But what about also adding device tree support for
> naming the chips while you're at it?
> 
> I imagine a generic gpiochip property in
> Documentation/devicetree/bindings/gpio/gpio.txt

Well, this has been discussed almost to death already (as you may
remember ;-) in the thread:

http://www.spinics.net/lists/devicetree/msg00072.html

(only portions survived)

Although I was in favour of the generic binding (as were you if I
remember correctly), the final non-conclusion was not to open the
"generic door". Fair enough with me, I went the defined-in-code way
here...

Pawe?
