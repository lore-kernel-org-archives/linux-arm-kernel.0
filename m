From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Jan 2016 00:24:24 +0100
Subject: [PATCH 1/2] ARM: versatile: add the syscon LEDs to the DT
In-Reply-To: <CAL_JsqLOLO0Y2h5LDruAutEGtjMfQPHhqUJ8mXEwAdgVW4JifQ@mail.gmail.com>
References: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
 <1452002529-3335-2-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqLOLO0Y2h5LDruAutEGtjMfQPHhqUJ8mXEwAdgVW4JifQ@mail.gmail.com>
Message-ID: <CACRpkdYg9SNaNvQJpOjBPbsp4tx4eia-fXLMgu7oynnKiqTHug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 5, 2016 at 4:37 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jan 5, 2016 at 8:02 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The device tree version of Versatile AP/PB never had LED support
>> so we are missing LEDs from our hardware boards. Add this as
>> syscon LEDs like we did for Integrator and Juno. We need to
>> spawn devices in the syscon with "simple-mfd" for this to work.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  arch/arm/boot/dts/versatile-ab.dts | 62 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 61 insertions(+), 1 deletion(-)
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> I guess this means you have tested my series on actual h/w now?

Yups tested today on Versatile AB. I sent some 4 different
patches for various issues (that were there all the time with
the device tree boot) and after that it works like a charm.

Yours,
Linus Walleij
