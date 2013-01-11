From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Jan 2013 21:12:43 +0100
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <50EF27B4.60608@wwwdotorg.org>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org>
Message-ID: <CACRpkdZ0b=ZohgaBH3qPH_O5TiWmXJXs6872D+YPVA9g4BssYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 9:42 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 12/12/2012 01:25 PM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This makes the device core auto-grab the pinctrl handle and set
>> the "default" (PINCTRL_STATE_DEFAULT) state for every device
>> that is present in the device model right before probe. This will
>> account for the lion's share of embedded silicon devcies.
>
> There are quite a few problems with this patch, and they end up
> completely breaking at least Tegra in next-20130110.

But I have not put this patch into linux-next.

I was still waiting for Greg to ACK it...

Apparently it was included in a pull request to the SH tree or something,
Simon can you remove these patches for now, this patch needs to
be elaborated on in the pinctrl tree first.

Yours,
Linus Walleij
