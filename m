From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 8 Jan 2015 13:17:35 -0800
Subject: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAMAWPa9fUJVjJ8V+93AkHy9DtEmUUnGs4MJDGcsoMdWwGmg5qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 5:31 AM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> Changes since v11:
> - Rebased on top of git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>
> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-dt driver for these platforms. This
> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
>
> This series is based on the following branch.
> git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>
> This series depends on the following patch which can be picked from
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git samsung/dt
> e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).
>
> This patch series has been tested on Exynos4210/5250/5420 based boards.
> Tomasz Figa had plans to take this in the Samsung clock tree for v3.19
> (http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
> Sylwester, could you consider to merge this in your tree?

CPUfreq for exynos is still not upstream.  What's the status of this
series?  It's been ver a month since there's been any activity here
(or any responses to the issues I reported.)

On a related note, this series only does frequency scaling. Is there
any work going on to also enable voltage scaling for the CPU rails as
well?

Thanks,

Kevin
