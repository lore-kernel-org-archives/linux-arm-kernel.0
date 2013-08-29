From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 30 Aug 2013 01:41:28 +0300
Subject: [Query] CPUFreq: Does these machines have separate clock domains
 for CPUs?
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Message-ID: <20130829224127.GA15841@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 29, 2013 at 03:45:58PM +0530, Viresh Kumar wrote:
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?
[...]
> drivers/cpufreq/loongson2_cpufreq.c

Loongson2 is UP only.

A.
