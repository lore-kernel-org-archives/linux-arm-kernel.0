From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Dec 2015 11:33:04 +0100
Subject: [PATCH RESEND] pinctrl: bcm2835: Fix initial value for
 direction_output
In-Reply-To: <1330071479.188146.762be339-5c35-483f-b17c-6076dc1d3758.open-xchange@email.1und1.de>
References: <1449511825-6156-1-git-send-email-stefan.wahren@i2se.com>
 <1330071479.188146.762be339-5c35-483f-b17c-6076dc1d3758.open-xchange@email.1und1.de>
Message-ID: <CACRpkdYPDo3-0M+1sHqPi9CAh9yeohcBepJCrQ2=OzRsuX4OJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 12:05 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Linus,
>
>> Stefan Wahren <stefan.wahren@i2se.com> hat am 7. Dezember 2015 um 19:10
>> geschrieben:
>>
>>
>> Currently the provided initial value for bcm2835_gpio_direction_output
>> has no effect. So fix this issue by changing the value before
>> changing the GPIO direction. As a result we need to move the function below
>> bcm2835_gpio_set.
>>
>> Suggested-by: Martin Sperl <kernel@martin.sperl.org>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>> Acked-by: Eric Anholt <eric@anholt.net>
>> ---
>
> on Nov 30 you wrote that you want Stephen's ACK and now it's there.

Yeal already applied it for fixes. Added the Fixes: tag now.

> But your current patch "[PATCH 092/182] pinctrl: bcm2835: use gpiochip data
> pointer" seems to conflict with my?

No problem. I will merge the next release candidate into the GPIO tree
and fix the conflicts after this fix is merged.

Fixing conflicts is all subsystem maintainers do some days :D

Yours,
Linus Walleij
