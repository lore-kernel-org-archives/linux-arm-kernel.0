From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Feb 2018 20:05:53 +0100
Subject: [PATCHv2 1/8] ARM: ux500: remove PMU IRQ bouncer
In-Reply-To: <20180205164202.26502-2-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-2-mark.rutland@arm.com>
Message-ID: <CACRpkdZmgO3L2=WAciYE23aLcO5ovN9TB7TMi8SPfu90UpiFjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 5, 2018 at 5:41 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> The ux500 PMU IRQ bouncer is getting in the way of some fundametnal
> changes to the ARM PMU driver, and it's the only special case that
> exists today. Let's remove it.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

It's OK this silicon design was especially strange it seems.
We are done with the days of performance optimization for
the platform anyways.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
