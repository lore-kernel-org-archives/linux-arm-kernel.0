From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 31 Oct 2012 09:22:04 -0400
Subject: [PATCH v3 04/11] clk: davinci - add pll divider clock driver
In-Reply-To: <CACRpkdY3ji_twCqej6Yf8grR7oovf3jeGrbQMzybk5CK5f2Y9A@mail.gmail.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-5-git-send-email-m-karicheri2@ti.com>
 <CACRpkdY3ji_twCqej6Yf8grR7oovf3jeGrbQMzybk5CK5f2Y9A@mail.gmail.com>
Message-ID: <509125FC.1090609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 03:26 PM, Linus Walleij wrote:
> On Thu, Oct 25, 2012 at 6:11 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
>> pll dividers are present in the pll controller of DaVinci and Other
>> SoCs that re-uses the same hardware IP. This has a enable bit for
>> bypass the divider or enable the driver. This is a sub class of the
>> clk-divider clock checks the enable bit to calculare the rate and
>> invoke the recalculate() function of the clk-divider if enabled.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Looking good,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
>
Linus,

Thanks. I will add your Acked-by in the next version.

Murali
