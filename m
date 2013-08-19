From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 19 Aug 2013 10:10:05 +0530
Subject: [PATCH 13/34] cpufreq: exynos5440: set CPUFREQ_NO_NOTIFICATION
 flag
In-Reply-To: <CADGdYn4frwbpjn94XE_G7pz0D=dcMG8_9zyqUsvKrVtQnphM5Q@mail.gmail.com>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
 <14993d27bdc6a91eced0af5eb96bdb5ca6546cbf.1376619363.git.viresh.kumar@linaro.org>
 <CADGdYn6TKURuO8jxL=tjvSLbmpUoUwoa08MZhsBAiEF91FM-cA@mail.gmail.com>
 <CADGdYn4frwbpjn94XE_G7pz0D=dcMG8_9zyqUsvKrVtQnphM5Q@mail.gmail.com>
Message-ID: <CAKohpon2UZbsZiq4r0r67FwJ+VtzCoM3=naH8qPR-PFaUGbycQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2013 09:12, amit daniel kachhap <amit.daniel@samsung.com> wrote:
>>> +       .flags          = CPUFREQ_STICKY | CPUFREQ_NO_NOTIFICATION,
> How about naming the flag as CPUFREQ_ASYNC_NOTIFICATION? For platforms
> not defining this flag, the notifiers can be called synchronously from
> the core driver.

Nice.. +1

My repo will be updated with this change..
