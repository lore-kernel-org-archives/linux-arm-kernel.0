From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 26 Nov 2012 20:27:10 +0530
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOh2x=k7UUDXigoZgWQGiCEWhZBhzZLY1yXbg+3b++56Z1MvdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 7:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
>
>  arch/arm/plat-spear/time.c               |    8 +-------

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
