From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 23:11:30 +0200
Subject: [PATCH 1/3] ARM: integrator: delete some auxdata
In-Reply-To: <201608301641.59299.arnd@arndb.de>
References: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
 <201608301641.59299.arnd@arndb.de>
Message-ID: <CACRpkdaWOPbJNijYp7omGWPd5_Z59AjRSkjDR35XLNN2VH-WeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 4:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 30 August 2016, Linus Walleij wrote:
>> There is just a few auxdata entries still needed on the Integrators:
>>
>> - UART RTS/CTS callbacks for Integrator/AP
>> - MMC/SD special card detect quirk for Integrator/CP
>>
>> Delete the rest.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Nice patches! I've had a look over them and they all seem reasonable,
> and I didn't see any obvious other parts that can be as easily removed
> here (I thought I did at first, but they all ended up being
> slightly trickier).

Yeah I will stack them all up and send as a combined cleanup+DTS
pull request, it has to be like that since the display patch and
some others can only be bisectable if code is removed from the
board files and added to the DTS at the same time.

Yours,
Linus Walleij
