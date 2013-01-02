From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Jan 2013 14:42:24 +0100
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <20121212215404.GA18555@kroah.com>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <20121212215404.GA18555@kroah.com>
Message-ID: <CACRpkdaLFjDh_k7BdrzvxNJ5E3ho-BV9n9tHey2AMzQzyuL+Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 10:54 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Dec 12, 2012 at 09:25:07PM +0100, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This makes the device core auto-grab the pinctrl handle and set
>> the "default" (PINCTRL_STATE_DEFAULT) state for every device
>> that is present in the device model right before probe. This will
>> account for the lion's share of embedded silicon devcies.
(...)
>
> It looks ok, but this can't go in for 3.8, sorry, please wait for 3.9.

Greg, now that v3.8-rc1 is out, can you give me an ACK on
this patch so I can put it into linux-next for some rotation
through the pinctrl tree?

Yours,
Linus Walleij
