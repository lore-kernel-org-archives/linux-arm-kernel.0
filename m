From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 02:08:13 +0100
Subject: [PATCH v2 11/18] pinctrl: Add pinctrl driver for STM32 MCUs
In-Reply-To: <2464742.YZIRrHto62@wuerfel>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
 <2464742.YZIRrHto62@wuerfel>
Message-ID: <CACRpkdZA4OMB+gqh6XKfYWR8RSLZGpYjj-cgrC_KcSfcon4QVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 4:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 20 February 2015 19:01:10 Maxime Coquelin wrote:

>> +/* Pull-Up/Down */
>> +#define NO_PULL                0
>> +#define PULL_UP                1
>> +#define PULL_DOWN      2
>> +
>> +/* Type */
>> +#define PUSH_PULL      (0 << 2)
>> +#define OPEN_DRAIN     (1 << 2)
>> +
>
> These should probably not be stm32 specific at all, they sound
> rather generic, so maybe put the definitions into a common file.

It's part of what GENERIC_PINCONF does and it has bindings
in Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Yours,
Linus Walleij
