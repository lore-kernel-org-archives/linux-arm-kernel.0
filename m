From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 12 Feb 2013 19:28:37 +0530
Subject: [PATCH 1/2 v2] drivers/db8500-cpufreq: delete dangling include
In-Reply-To: <1360669434-21752-1-git-send-email-linus.walleij@stericsson.com>
References: <1360669434-21752-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x=mNVGzGgjL0vs5EeV+rxeM0v4ToY5rzSgbraiKnNoCkvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 5:13 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> There was a dangling #include <mach/id.h> in the cpufreq
> file missing from commit
> 7a4f26097d389c16c9956bc03b81532698d97d64
> "ARM: ux500: de-globalize <mach/id.h>"
>
> Causing build regressions when building with cpufreq
> support.
>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
