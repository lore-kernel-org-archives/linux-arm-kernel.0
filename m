From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Jun 2017 00:08:55 +0200
Subject: [PATCH v8] clk: Add Gemini SoC clock controller
In-Reply-To: <20170621174540.GB4493@codeaurora.org>
References: <20170621075952.26387-1-linus.walleij@linaro.org>
 <20170621174540.GB4493@codeaurora.org>
Message-ID: <CACRpkdbv9L1mwtaBTW93BNkGbPcRjsO5yda+SY2iHUSL41Q2ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 7:45 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/21, Linus Walleij wrote:
>> The Cortina Systems Gemini (SL3516/CS3516) has an on-chip clock
>> controller that derive all clocks from a single crystal, using some
>> documented and some undocumented PLLs, half dividers, counters and
>> gates. This is a best attempt to construct a clock driver for the
>> clocks so at least we can gate off unused hardware and driver the
>> PCI bus clock.
>>
>> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>
> Applied to clk-next + this fixup

Thanks, and thanks a lot for fixing.

Hm, I copied that code from somewhere.

Now I need to try to remember where so I can go and
fix the bad example.

Yours,
Linus Walleij
