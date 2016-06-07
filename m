From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 7 Jun 2016 19:10:17 +0530
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
In-Reply-To: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAKohpon_euKo0Wu8fwU34EUxgBQBrL5TtbuYdvUdNt0ebK+rkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2016 at 17:00, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Fix the use of 0 instead of NULL to clk_get() call. This stops the
> following warning:
>
> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pm at vger.kernel.org
> Cc: linux-kernel at lists.codethink.co.uk
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
