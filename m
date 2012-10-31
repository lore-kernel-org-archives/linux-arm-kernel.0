From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 31 Oct 2012 09:23:01 -0400
Subject: [PATCH v3 03/11] clk: davinci - common clk utilities to init
 clk driver
In-Reply-To: <CACRpkdZeor=V624OvBek1FccWFvYr2=mPBXZat8ELTtNTTL_rw@mail.gmail.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-4-git-send-email-m-karicheri2@ti.com>
 <CACRpkdZeor=V624OvBek1FccWFvYr2=mPBXZat8ELTtNTTL_rw@mail.gmail.com>
Message-ID: <50912635.5080009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 03:25 PM, Linus Walleij wrote:
> On Thu, Oct 25, 2012 at 6:11 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
>> This is the common clk driver initialization functions for DaVinci
>> SoCs and other SoCs that uses similar hardware architecture.
>> clock.h also defines struct types for clock definitions in a SoC
>> and clock data type for configuring clk-mux. The initialization
>> functions are used by clock initialization code in a specific
>> platform/SoC.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> This is looking good.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
>
Linus,

Thanks. I will add your Acked-by in the next revision of the patch.

Murali
