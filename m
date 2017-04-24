From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 24 Apr 2017 18:06:10 +0200
Subject: [PATCH v2 6/7] ARM: Kconfig: Introduce MACH_STM32F469 flag
In-Reply-To: <CACRpkdZmWFKaZWB8qZaH=jB61xdwvJ=TC8idYH9kJdi=HEZRAA@mail.gmail.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-7-git-send-email-alexandre.torgue@st.com>
 <CACRpkdZmWFKaZWB8qZaH=jB61xdwvJ=TC8idYH9kJdi=HEZRAA@mail.gmail.com>
Message-ID: <a45e5791-cca1-79b8-a368-6d113c933ec3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 04/24/2017 02:30 PM, Linus Walleij wrote:
> On Fri, Apr 7, 2017 at 2:43 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>
>> This patch introduces the MACH_STM32F469 to make possible to only select
>> STM32F469 pinctrl driver
>>
>> By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.
>>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please funnel this through the ARM SoC tree.

Yes, I'll merge it in future pull request.
Thanks for the series.

Regards
Alex

>
> Yours,
> Linus Walleij
>
