From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:54:55 +0100
Subject: [PATCH 5/6] arm: sa1100: h3xxx: move serial port GPIO handling to
 common place
In-Reply-To: <1385048414-9812-6-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <1385048414-9812-6-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdbw8_Yhh+dyMbMAzRC_JdkiuMwP9L8GOASvp=Xn+5Awxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Both h3100 and h3600 request UART gpios during init_machine time. As
> sa1100 gpio driver is going to become proper machine driver, move gpio
> handling to UART port functions. Request all gpios using gpio_request
> array once and then guard them from rerequesting with bool variable.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
