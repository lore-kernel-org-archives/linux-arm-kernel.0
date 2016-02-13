From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 13 Feb 2016 15:42:20 +0100
Subject: [PATCH 0/3] OMAP/pinmux: remove misuse of IRQF_NO_SUSPEND flag
In-Reply-To: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CACRpkdYzJ9Hy0sH6gK6RzpLE6juS4WfPjbt7nh43vR9YTuGZWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 7:28 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>   pinctrl: single: Use a separate lockdep class
>   pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
>   ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
>
>  arch/arm/mach-omap2/mux.c        |  4 ++--
>  arch/arm/mach-omap2/pm34xx.c     |  9 ++++-----
>  arch/arm/mach-omap2/prm_common.c |  1 +
>  drivers/pinctrl/pinctrl-single.c | 15 ++++++++++++---

Are these patches orthogonal so I can merge the pinctrl patch independently
of the OMAP patches if Tony ACKs this?

If not: should it be merged by me or through ARM SoC/Tony?

Anyways waiting for maintainer feedback, but the above is good to know.

Yours,
Linus Walleij
