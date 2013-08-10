From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Aug 2013 08:23:02 +0530
Subject: [PATCH 35/35] cpufreq: tegra: use
 cpufreq_table_validate_and_show()
In-Reply-To: <52056842.8060109@wwwdotorg.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
 <5203BCDD.40809@wwwdotorg.org>
 <CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
 <CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
 <5205167F.1070906@wwwdotorg.org>
 <CAKohponQDAqHiRD7Aw5Wk6fEE-d8H=Svg0oBRyb9SKGdqYxGhw@mail.gmail.com>
 <52056842.8060109@wwwdotorg.org>
Message-ID: <CAKohpon=j=NANLQzYuBdoFVLxQzETy5JDu2vORaAgK3NuEpeAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 August 2013 03:38, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Well, I don't see any issues running this, although the cpufreq sysfs
> files seem to have disappeared on Tegra, even without your changes, so
> I'm not sure how to really verify cpufreq.
>
> Did the sysfs files go away, or do I need to investigate why/when the
> disappeared?

It wasn't enabled by default in your defconfig... So enable it first with
your menuconfig.
