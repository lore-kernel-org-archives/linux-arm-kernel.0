From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 21:55:04 +0100
Subject: [PATCH v8 09/12] pinctrl: generic: add auto pull config parameter
In-Reply-To: <20130215163755.GB5724@atomide.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdYKAexLu30M2KzKcRcvRJS=xfVMB2vR+CgAXmwQ0+_ZzA@mail.gmail.com>
 <20130215163755.GB5724@atomide.com>
Message-ID: <CACRpkdY6bsxg6FG5bSCPZKkQ4-mVyiOsCFsh-421_nLCLcasSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 5:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130215 00:58]:
>> On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>> > There's only one bit to control pin bias as enabled or disabled for some
>> > pins in OMAP SoC. So append PIN_CONFIG_BIAS_AUTO_PULL for this case.
>> > User shouldn't switch pin state between AUTO_PULL and PULL_UP/PULL_DOWN,
>> > since they're similiar concepts.
>> >
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>
>> Makes perfect sense.
>> Patch applied with Tony's ACK!
>
> Sorry the conclusion was that this probably won't be needed and can
> probably be done with just PULL_UP/PULL_DOWN.
>
> So can you please drop or revert this AUTO_PULL one?

Sorry I was drunk or something.

I never applied this patch, I applied the other one,
with the title "pinctrl: generic: rename input schmitt disable".

This one stays out.

Yours,
Linus Walleij
