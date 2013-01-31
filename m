From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 Jan 2013 21:42:01 +0530
Subject: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
In-Reply-To: <1604688.EafV1ohaV9@amdc1227>
References: <1887364.fvxYYNb7Mm@amdc1227> <1520678.Zm627xxIN3@amdc1227>
 <CAKohpomEcrPa7UnZmtTouxN6JXxcaa7dBstMGUWjXGL0n1+=Ng@mail.gmail.com>
 <1604688.EafV1ohaV9@amdc1227>
Message-ID: <CAKohpo=_cR7dk_V2+6bQwUMk-raa3ENAJqBCSe_mYfS+Ur8PnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2013 21:37, Tomasz Figa <t.figa@samsung.com> wrote:
> Hmm. Now as I think of it, there might be another confusing aspect:
>
> Could you explain what "sw coordination" and "any coordination" mean?
> I mean specifically cpufreq_policy.cpus and cpufreq_policy.related_cpus
> masks.

Check this out:

https://lkml.org/lkml/2013/1/30/587
