From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 5 May 2014 20:05:44 +0530
Subject: [PATCH 2/2] PM / OPP: Move cpufreq specific OPP functions out of
 generic OPP library
In-Reply-To: <1399296830-13056-3-git-send-email-nm@ti.com>
References: <1399296830-13056-1-git-send-email-nm@ti.com>
 <1399296830-13056-3-git-send-email-nm@ti.com>
Message-ID: <CAKohpom0nq_v0wzaLtU4NxRxJwLgrUB1K8+9QtkanibeznEi4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2014 19:03, Nishanth Menon <nm@ti.com> wrote:
> CPUFreq specific helper functions for OPP (Operating Performance Points)
> now use generic OPP functions that allow CPUFreq to be be moved back
> into CPUFreq framework. This allows for independent modifications
> or future enhancements as needed isolated to just CPUFreq framework
> alone.
>
> Here, we just move relevant code and documentation to make this part of
> CPUFreq infrastructure.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: cpufreq at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
