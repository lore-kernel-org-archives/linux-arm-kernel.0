From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 11:10:35 +0530
Subject: [PATCH v2] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <53826377.8060709@samsung.com>
References: <1400670752-673-1-git-send-email-t.figa@samsung.com>
 <1400858533-4327-1-git-send-email-t.figa@samsung.com>
 <53826377.8060709@samsung.com>
Message-ID: <CAKohpo=b=Jm4vZfgS2YPA740QfvktgVExXXzOdSUmQjGWhzrhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2014 03:11, Kukjin Kim <kgene.kim@samsung.com> wrote:
> I'm not sure Thomas' v5 cpufreq-cpu0 driver can be upstreamed for 3.16
> because of dependency with others, some of them got ack though...
>
> * "PM / OPP: move cpufreq specific helpers out of OPP layer"
> - https://www.mail-archive.com/linux-omap at vger.kernel.org/msg104610.html

This is already lying in Rafael's tree.

> * "cpufreq: opp: Add device tree based lookup of boost mode frequency"
> - http://www.spinics.net/lists/arm-kernel/msg334336.html
>
> So firstly, I've queued this instead with exynos-multiplatform series...
>
> How do you think?

Looks fine to me. Thanks.
