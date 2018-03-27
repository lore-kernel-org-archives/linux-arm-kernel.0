From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:24:16 +0200
Subject: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
In-Reply-To: <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-3-swboyd@chromium.org>
 <1521655150.23017.79.camel@linux.intel.com>
 <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
Message-ID: <CACRpkdbg40yaKVbo-b6UKAYfGpT2ZLDdXaPKgEn-4zGL4mKuag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 8:59 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Andy Shevchenko (2018-03-21 10:59:10)
>> On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
>> > From: Stephen Boyd <sboyd@codeaurora.org>
>> >
>> > Some qcom platforms make some GPIOs or pins unavailable for use by
>> > non-secure operating systems, and thus reading or writing the
>> > registers
>> > for those pins will cause access control issues. Add support for a DT
>> > property to describe the set of GPIOs that are available for use so
>> > that
>> > higher level OSes are able to know what pins to avoid reading/writing.
>> > Non-DT platforms can add support by directly updating the
>> > chip->valid_mask.
>>
>> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>
>> Hmm...
>
> Don't look closely! :P

Same physical person acting on behalf of two different legal
entities right? Seems OK to me.

Yours,
Linus Walleij
