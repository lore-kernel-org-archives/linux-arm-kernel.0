From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 31 Oct 2012 09:23:51 -0400
Subject: [PATCH v3 01/11] clk: davinci - add main PLL clock driver
In-Reply-To: <CACRpkdaa8f7N90hknaqZmNeYD1SjQx6Fm35nS34CxwnH+fwEfg@mail.gmail.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-2-git-send-email-m-karicheri2@ti.com>
 <CACRpkdaa8f7N90hknaqZmNeYD1SjQx6Fm35nS34CxwnH+fwEfg@mail.gmail.com>
Message-ID: <50912667.9030909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 03:18 PM, Linus Walleij wrote:
> On Thu, Oct 25, 2012 at 6:11 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
>> This is the driver for the main PLL clock hardware found on DM SoCs.
>> This driver borrowed code from arch/arm/mach-davinci/clock.c and
>> implemented the driver as per common clock provider API. The main PLL
>> hardware typically has a multiplier, a pre-divider and a post-divider.
>> Some of the SoCs has the divider fixed meaning they can not be
>> configured through a register. HAS_PREDIV and HAS_POSTDIV flags are used
>> to tell the driver if a hardware has these dividers present or not.
>> Driver is configured through the struct clk_pll_data that has the
>> SoC specific clock data.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> This looks good to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
>
>
Linus,

Thanks. I will add your Acked-by in the next revision of the patch.

Murali
