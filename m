From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Oct 2016 10:16:43 +0200
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <87lgyh6at5.fsf@eliezer.anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
 <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
 <87mviy92qw.fsf@eliezer.anholt.net>
 <CACRpkdbJoM-RbcuoC=7xJyrT3v7p2n9HiidRp1GUw=o43_Fkwg@mail.gmail.com>
 <87lgyh6at5.fsf@eliezer.anholt.net>
Message-ID: <CACRpkda5=zqbZSOSyhEmaGg2RUKGPQwcQJ1jmv55t+F==xvSJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 9:01 AM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

>> Sorry I am not familiar with your development model. I don't know
>> about any RPI downstream tree... What I mean is that the patch to
>> include/soc/bcm2835/raspberrypi-firmware.h should be merged by
>> whoever is maintaining that file, it is not a GPIO file.
>>
>> If I get an ACK from the maintainer I can take it into the GPIO
>> tree.
>
> Oh, people often say "the rpi tree" to mean downstream (currently 4.4).
> The maintainer of that file upstream is me, and I was hoping you could
> merge through your tree.

OK no problem, I can merge it once we agree on the mechanics :)

Yours,
Linus Walleij
