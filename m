From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Feb 2018 11:26:12 +0000
Subject: [PATCHv2 1/8] ARM: ux500: remove PMU IRQ bouncer
In-Reply-To: <CACRpkdZmgO3L2=WAciYE23aLcO5ovN9TB7TMi8SPfu90UpiFjA@mail.gmail.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-2-mark.rutland@arm.com>
 <CACRpkdZmgO3L2=WAciYE23aLcO5ovN9TB7TMi8SPfu90UpiFjA@mail.gmail.com>
Message-ID: <20180206112612.c7ciffpizekx7ax7@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 08:05:53PM +0100, Linus Walleij wrote:
> On Mon, Feb 5, 2018 at 5:41 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > The ux500 PMU IRQ bouncer is getting in the way of some fundametnal
> > changes to the ARM PMU driver, and it's the only special case that
> > exists today. Let's remove it.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> It's OK this silicon design was especially strange it seems.
> We are done with the days of performance optimization for
> the platform anyways.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Cheers!

Mark.
