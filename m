From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 8 Feb 2016 18:23:16 +0100
Subject: [PATCH] pinctrl: stm32: fix compile error and modernize
In-Reply-To: <1454712568-6301-1-git-send-email-linus.walleij@linaro.org>
References: <1454712568-6301-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CALszF6CYa50SZGys4KmCxkRa0Kp6n1OHdRPUA9C+Lj7erSBjWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-05 23:49 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> - Fix the dev->parent assignment compile error
> - Use gpiochip_get_data() to get the data pointer for the
>   banks
>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I don't even know how to compile test this, I hope it works,
> Maxime can you verify?

Thanks Linus, I just tested your patch with success:
Tested-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

About the compile testing, I have identified the problem last week,
and sent a v5 of the series.
I will discard this series, and will send you a patch that fixes
compile testing,
and also unneeded dependency with DT bindings header file.

Regards,
Maxime
