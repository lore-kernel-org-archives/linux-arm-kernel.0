From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:06:28 -0700
Subject: mfd: Implement devicetree support for AB8500 Btemp
In-Reply-To: <201209101401.06859.arnd@arndb.de>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
 <201209101401.06859.arnd@arndb.de>
Message-ID: <CACRpkdb4yMCatQRhfWqo=pkWrNjd87ephOdVJeU7oMqnF1UZ2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 7:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 10 September 2012, Rajanikanth HV wrote:

>> +               thermister-internal-to-battery = <1>;
>> +               li_ion_9100_battery = <0>;
>
> Boolean properties should be empty when enabled and not present when
> disabled. In this example, one would just write
>
>                 thermister-internal-to-battery;

I also think the proper word is "thermistor":
http://en.wikipedia.org/wiki/Thermistor

Yours,
Linus Walleij
