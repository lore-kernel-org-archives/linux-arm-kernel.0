From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Aug 2017 10:11:13 +0200
Subject: [PATCH] clk: gemini: hands off PCI OE bit
In-Reply-To: <20170809014312.GZ2146@codeaurora.org>
References: <20170808190818.11740-1-linus.walleij@linaro.org>
 <20170809014312.GZ2146@codeaurora.org>
Message-ID: <CACRpkda0cLMuiipEBX+mH6MJ3v6k=CY+q=Q6NUj=BM+6wnFO2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 3:43 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/08, Linus Walleij wrote:
>> This bit is pin control, and needs to be carefully managed by the
>> new pin control driver.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Fixes tag?

It's not a fix, it'd just that we move the responsibility of managing the
pin from the clock driver to the pin control driver.

I initially thought the Gemini would not need a separate pin control
driver because it was "simple" ... so these bits could be handled here
and there among the peripherals. Little did I know. Mea culpa.

> Does this need to be merged now as a critical fix? Or we can wait
> on it for next release?

Just put it in for the next release, thanks!

Yours,
Linus Walleij
