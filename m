From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 10:38:12 +0100
Subject: [PATCH] ARM: dts: add the AB8500 clocks to the device tree
In-Reply-To: <20170313220852.GB13064@localhost>
References: <20170226000209.20534-1-linus.walleij@linaro.org>
 <20170313220852.GB13064@localhost>
Message-ID: <CACRpkdajboNdMLpVM7SL0Ov5uj8BFksefSkmfiS2M2BjXjyVmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 11:08 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Feb 26, 2017 at 01:02:09AM +0100, Linus Walleij wrote:
>> This adds the AB8500 clocks to the device tree using the new
>> bindings from the clk subsystem, making audio work again.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ARM SoC guys: please consider this for late merge/early fix.
>>
>> Lee had audio working at some point in the past, but there is no
>> way of fixing it backward or for stable. However: applying this
>> fixes it for v4.11.
>>
>> ChangeLog v1->v2:
>> - Rename DT node to clock-controller.
>
> Thanks, I'm interpreting this as a fix (at least this early in the release
> cycle, and merging it for 4.11 fixes).

Yes, thanks a lot. It's a fix indeed, the sound card comes up
after this.

Yours,
Linus Walleij
