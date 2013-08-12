From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 12 Aug 2013 22:31:20 +0530
Subject: [PATCH 35/35] cpufreq: tegra: use
 cpufreq_table_validate_and_show()
In-Reply-To: <52090E67.1080703@wwwdotorg.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
 <5203BCDD.40809@wwwdotorg.org>
 <CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
 <CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
 <5205167F.1070906@wwwdotorg.org>
 <CAKohponQDAqHiRD7Aw5Wk6fEE-d8H=Svg0oBRyb9SKGdqYxGhw@mail.gmail.com>
 <52056842.8060109@wwwdotorg.org>
 <CAKohpon=j=NANLQzYuBdoFVLxQzETy5JDu2vORaAgK3NuEpeAg@mail.gmail.com>
 <52090E67.1080703@wwwdotorg.org>
Message-ID: <CAKohpom4WsD_BSSGEbtmGR3JRzPXx9j1exM7CagwOXZ=0GZnGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2013 22:03, Stephen Warren <swarren@wwwdotorg.org> wrote:
> It's in defconfig OK; I think the driver simply isn't initializing since
> some of the clocks it requests don't exist. I'll have our clock driver
> author look into it. In the meantime, I assume that your change is
> likely fine.

I wasn't' talking about your driver but cpufreq_stats.. That is disabled
by default with your defconfig.
