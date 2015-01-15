From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Jan 2015 17:16:01 +0100
Subject: [PATCH v2 RESEND 2/3] Documentation: gpio: Add APM X-Gene standby
 GPIO controller DTS binding
In-Reply-To: <CAL4ahLfcMsu2i2efiwq96a3YD4dChBEuJeEnQ7tsZH6et8H=sw@mail.gmail.com>
References: <1418793050-26927-1-git-send-email-yvo@apm.com>
 <1418793050-26927-3-git-send-email-yvo@apm.com>
 <CACRpkdbcdf7Ub9uYbeqUe1La1dnVeWCxK8N7=iVZuBtuKHFHFA@mail.gmail.com>
 <CAL4ahLfcMsu2i2efiwq96a3YD4dChBEuJeEnQ7tsZH6et8H=sw@mail.gmail.com>
Message-ID: <CACRpkdaQWf6jOFkX1Lq0NWm_wfxw1NuajOwpJwA5_sZ8CdAa4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 10:41 AM, Y Vo <yvo@apm.com> wrote:
> Yes, exactly 6 interrupts. As I describe before:
> - There are 22 GPIO_DSs.
> - Only 6 GPIO_DSs from 0x08..0xD which supports interrupts

What I'm saying is that you need to describe this in the binding
document itself.

If you described it somewhere else doesn't count.

So update the patch.

Yours,
Linus Walleij
