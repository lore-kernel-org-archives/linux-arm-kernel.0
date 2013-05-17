From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 08:29:01 +0200
Subject: ux500 breaking multi-platform kernels
In-Reply-To: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
References: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
Message-ID: <CACRpkdbJosO7Ea8=BUdgVSf5fZwddWZb79ONaz3r+DqseAaF7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 10:30 PM, Rob Herring <robherring2@gmail.com> wrote:

> There are some initcalls on ux500 that are not properly
> conditionalized.

Oh wow you actually compiled it in and tried to boot it on something
else :-D

Highbank I suppose?

> The first is in ux500_l2x0_init and here is a fix:

I guess this is all -rc material. Can you send a proper patch (set)?

Unfortunately I don't have any other ARMv7 system than ux500 so
I cannot test multiplatform on any other machine myself.
(I have several ARMv5:s...)

Yours,
Linus Walleij
