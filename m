From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Jan 2015 01:04:10 +0100
Subject: [PATCH v3 5/8] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <CACRpkdZk3sLN43zmuWM+VYLB7vJdNCSq_goTx6mDSnzHrO=UHw@mail.gmail.com>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420803212-4350-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CACRpkdZk3sLN43zmuWM+VYLB7vJdNCSq_goTx6mDSnzHrO=UHw@mail.gmail.com>
Message-ID: <CACRpkdajpv0yK-m3WRxRRKJyQiBZxRppOiay+-CLTr_adOw9ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 11:40 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> First I thought maybe this could use the generic MMIO driver
> but it seems you need this double register access for setting
> the direction so it won't work.
>
> Otherwise it's sort of close ... have you looks at the option?

Bah, sorry I saw I already asked this in the past and you explained
that the arithmetic is not simple enough. Sorry for forgetting what
I already asked. This is over all looking very good, but waiting since
you had some pending change, then I'll merge it.

Yours,
Linus Walleij
