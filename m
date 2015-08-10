From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Aug 2015 11:01:48 +0200
Subject: [PATCH] ARM/EP93xx/timer: Migrate to new 'set-state' interface
In-Reply-To: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
References: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdZknzqgH+-F0MZgZywtoOL1hhbg=7w1RSC5aZohXtDB3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 11:11 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Migrate EP93xx driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Linus,
>
> All other clockevent drivers are migrated to the new interface and yours
> was left as it adapted generic clockevents framework just now.
>
> Probably Olof can apply it directly to ARM SoC tree..

Sure, but does it work right off or does Olof have to
pull a branch from your tree in for it to work? In that
case I suggest you take this in the -rc phase. Anyways:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
