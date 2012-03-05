From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 5 Mar 2012 11:46:54 -0800
Subject: [PATCH v5 2/4] clk: Kconfig: add entry for HAVE_CLK_PREPARE
In-Reply-To: <20120305020410.GB3261@b20223-02.ap.freescale.net>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-3-git-send-email-mturquette@linaro.org>
 <20120305020410.GB3261@b20223-02.ap.freescale.net>
Message-ID: <CAJOA=zOKB-VCKFe7Oh46Wx0FEwub3d8xwSQUuzC1w_soVQXcVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 4, 2012 at 6:04 PM, Richard Zhao <richard.zhao@freescale.com> wrote:
> On Sat, Mar 03, 2012 at 12:28:59AM -0800, Mike Turquette wrote:
>> The common clk framework provides clk_prepare and clk_unprepare
>> implementations. ?Create an entry for HAVE_CLK_PREPARE so that
>> COMMON_CLK can select it.
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Arnd Bergman <arnd.bergmann@linaro.org>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Richard Zhao <richard.zhao@linaro.org>
>> Cc: Saravana Kannan <skannan@codeaurora.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Amit Kucheria <amit.kucheria@linaro.org>
>> Cc: Deepak Saxena <dsaxena@linaro.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> ---
>> ?drivers/clk/Kconfig | ? ?3 +++
>> ?1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 9b3cd08..3912576 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -8,3 +8,6 @@ config HAVE_CLK_PREPARE
>>
>> ?config HAVE_MACH_CLKDEV
>> ? ? ? bool
>> +
>> +config HAVE_CLK_PREPARE
>> + ? ? bool
> We've already had it. redundant?

I didn't realize that Shawn merged this in since the last posting of V4...

Will drop it.

Regards,
Mike

>
> Thanks
> Richard
>> --
>> 1.7.5.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
