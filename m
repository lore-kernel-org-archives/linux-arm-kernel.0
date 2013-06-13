From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jun 2013 17:31:45 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <201306131635.21446.heiko@sntech.de>
References: <201306102139.32444.heiko@sntech.de>
 <201306130022.29341.heiko@sntech.de>
 <CACRpkdb-vbdQJOeZvCEsKLatK-0BhEfUTJqmGURJGf1NWx__Ew@mail.gmail.com>
 <201306131635.21446.heiko@sntech.de>
Message-ID: <CACRpkdZw+3BQdVm2w6wzqy5LFO0Yw8avQLiB0hxtspvShPbk0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 4:35 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Donnerstag, 13. Juni 2013, 10:11:28 schrieb Linus Walleij:
>> Tisdagen den 13:e Juni 2013 klock 12:22 AM, skrev Heiko St?bner

>> > The only other candidate I could find was low-power-mode which really
>> > could use a "1" as default. All the other pinconf options either use
>> > custom arguments or ignore teir argument.
>>
>> A "1" for what? Not quite following....
>
> According to the pinconf header docs, low-power-mode also expects an argument
> of 1 or 0. So it's default value should change too ... or we could rename the
> property, like "low-power-enable" and "low-power-disable", which might make
> the dt more readable than an arbitary low-power-mode = <0>;

Oh yes, sorry, of course. Go ahead with this.

Yours,
Linus Walleij
