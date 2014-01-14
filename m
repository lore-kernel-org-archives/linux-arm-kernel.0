From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jan 2014 11:30:50 +0100
Subject: [RFC 03/18] GPIO: gpio-generic: Add label to platform data
In-Reply-To: <1389196639.23721.16.camel@hornet>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-4-git-send-email-pawel.moll@arm.com>
 <CACRpkdb4w26vuOtR1bAhQ6k=1uQx=np4WwoabvH8pOq8HK54=w@mail.gmail.com>
 <1389196639.23721.16.camel@hornet>
Message-ID: <CACRpkdb4X+=Tpe_+U0ixyQTA3BbtX17wk=y=63CVkQsdLo60iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 4:57 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Mon, 2013-12-23 at 17:26 +0000, Linus Walleij wrote:

>> Good point. But what about also adding device tree support for
>> naming the chips while you're at it?
>>
>> I imagine a generic gpiochip property in
>> Documentation/devicetree/bindings/gpio/gpio.txt
>
> Well, this has been discussed almost to death already (as you may
> remember ;-) in the thread:
>
> http://www.spinics.net/lists/devicetree/msg00072.html
>
> (only portions survived)
>
> Although I was in favour of the generic binding (as were you if I
> remember correctly), the final non-conclusion was not to open the
> "generic door". Fair enough with me, I went the defined-in-code way
> here...

OK I buy this. I am willing to apply this patch. Just a problem:

Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

I can't apply this patch :-)

Please consult your fellow upstream developers on how to get
the mail out of the ARM offices in a form that I can apply...

Yours,
Linus Walleij
