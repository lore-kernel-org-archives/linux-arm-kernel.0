From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 13:11:08 +0200
Subject: [PATCH 15/41] clocksource: nomadik-mtu: Migrate to new
 'set-state' interface
In-Reply-To: <34bfbe2960c02dfc6ed20fd4ac72bdb755ed2444.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <34bfbe2960c02dfc6ed20fd4ac72bdb755ed2444.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdb_Mwnp=V8-0evMqRoVzOQs0yPHbzW2shcTnBC1scYYzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 12:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Migrate nomadik-mtu driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
