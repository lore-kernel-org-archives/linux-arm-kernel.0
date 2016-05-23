From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 May 2016 15:49:16 +0200
Subject: [PATCH v2 3/4] ARM64: Kconfig: Select the Amlogic Meson pin
 controller driver
In-Reply-To: <CAOQ7t2aLORBKiuZEp1BZ1+O-Yr5xvM9bjkFnfA9Yn9oZZefSnw@mail.gmail.com>
References: <1462176138-29433-1-git-send-email-carlo@caione.org>
 <1462176138-29433-4-git-send-email-carlo@caione.org>
 <CACRpkdbTr7YUrzSQQci929ugBhTkJKWvpjdf5Wo3HkfVKFhGLw@mail.gmail.com>
 <3200982.vJgYKNLqaA@wuerfel>
 <CAOQ7t2aLORBKiuZEp1BZ1+O-Yr5xvM9bjkFnfA9Yn9oZZefSnw@mail.gmail.com>
Message-ID: <CACRpkdY9jLeUzixZQ4_RoOJqpT7iHOHZi55K6htUeKQFjO2FgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 8:41 PM, Carlo Caione <carlo@caione.org> wrote:
> On Wed, May 11, 2016 at 12:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 11 May 2016 10:53:35 Linus Walleij wrote:
>>> On Mon, May 2, 2016 at 10:02 AM, Carlo Caione <carlo@caione.org> wrote:
>>>
>>> > From: Carlo Caione <carlo@endlessm.com>
>>> >
>>> > Select the Meson pin controller driver also for the AArch64 Meson
>>> > platform.
>>> >
>>> > Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> I guess this should get merged through the ARM SoC tree.
>>>
>>
>> I'd keep it together with the other changes for clarity and
>> merge it through your tree.
>
> Linus,
> did you take it? otherwise I can merge it through my repo.

Nope didn't pick this one. I prefer to not take such patches
since they tend to generate collissions. Please take this
through ARM SoC.

Yours,
Linus Walleij
