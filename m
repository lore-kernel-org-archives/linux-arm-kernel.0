From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 14 Sep 2015 09:50:20 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <1442215849.8778.101.camel@collabora.co.uk>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <CABxcv=nRjge1qMeoXt6U6McKbv30oYUhh9C417mX0B=bt9Jg-g@mail.gmail.com>
 <1442215849.8778.101.camel@collabora.co.uk>
Message-ID: <CABxcv==JF5QKG8qmrRRUSi4j0=7guQQJTzVzR2bgSxdtUDBv7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sjoerd,

On Mon, Sep 14, 2015 at 9:30 AM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:

[snip]

>> > +
>> > +                       vcc18_lcd: REG12 {
>> > +                               regulator-name = "VCC18_LCD";
>> > +                               regulator-min-microvolt =
>> > <1800000>;
>> > +                               regulator-max-microvolt =
>> > <1800000>;
>> > +                               regulator-always-on;
>> > +                       };
>>
>> Should all these regulators really need to be always-on?
>
> Ideally not all of them, turning the ones that aren't needed off is
> definately on my list of things to do (together with the other
> pheripherals, leds, hw. keys etc).
>
> For the first patch i do prefer to keep them on so we can have get some
> more testing  with this board before fine-tuning those things (fwiw,

Ok.

> the rockchip evb board and others with essentially the same pmic setup
> all also have them always-on)

Yes but I believe that's because it was easier and there are
regulators on these boards that don't need to be always-on as well.

> --
> Sjoerd Simons
> Collabora Ltd.

Best regards,
Javier
