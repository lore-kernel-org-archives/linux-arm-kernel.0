From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 May 2012 13:24:45 +0200
Subject: [PATCH 02/15] ARM: ux500: Remove unused i2c platform_data
 initialisation code
In-Reply-To: <4FAA4576.1020106@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ70FasMuTTgBe68xaePB-4UNZ0W44BCxDve7fqXYT+vg@mail.gmail.com>
 <4FAA4576.1020106@linaro.org>
Message-ID: <CACRpkdbnXutBe=0Ng70BxTH3Qh87uyU=NO1f4U-8iZyPu2NvaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 12:22 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 09/05/12 09:46, Linus Walleij wrote:
>> So why not copy the contents of arch/arm/plat-nomadik/include/plat/i2c.h
>> into drivers/i2c/busses/i2c-nomadik.c and delete that header from
>> plat at the same time?
>>
>> Then there sure is no way for platforms to sneak in any platform
>> data any other way.
>
> I have no problem in doing that. Can I submit a separate patch?

Sure. Acked-by on this then...

Yours,
Linus Walleij
