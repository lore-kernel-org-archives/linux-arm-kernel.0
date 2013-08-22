From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Aug 2013 13:59:09 -0600
Subject: [PATCH 09/16] clk: samsung: pll: Use new registration method
 for PLL45xx
In-Reply-To: <CAKew6eV79H60iU9X5DKOKo57Y51RfVtML2qEqD1z4m6rT_yLJA@mail.gmail.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
 <1377019903-14614-10-git-send-email-t.figa@samsung.com>
 <CAKew6eV79H60iU9X5DKOKo57Y51RfVtML2qEqD1z4m6rT_yLJA@mail.gmail.com>
Message-ID: <52166D8D.1070900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2013 07:17 AM, Yadwinder Singh Brar wrote:
>>  };
>>
>> +static struct __initdata samsung_pll_clock exynos4210_plls[nr_plls] = {
> 
> NIT: __initdata should be at last.

It's helpful if you only quote as much of the patch as you need to in
order to reply to it; it wasn't obvious in your message that you had no
comments on the rest of the patch that you quoted, so people have to
scroll through it looking carefully for any other comments.
