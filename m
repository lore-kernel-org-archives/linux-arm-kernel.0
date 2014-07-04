From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Jul 2014 15:25:35 +0530
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 15:14, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> This commit adds a simple cpufreq driver for the Armada XP SoC, which
> has one separately controllable clock for each CPU. For this reason,
> the existing cpufreq-cpu0 generic driver cannot be used because it
> currently assumes that there is only one clock controlling the
> frequency of all CPUs.
>
> There are on-going discussions on extending the cpufreq-cpu0 to cover
> the case of having one clock for each CPU, but there are still some
> unresolved issues to get this extended cpufreq-cpu0 driver merged.

Exactly, and those changes would get merged in one form or the other.
Surely in 3.17 atleast, if not 3.16 as we are already reaching rc4..

So, it would be great if you can test on top of those changes to see if
something isn't solved for your platform yet?

git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/cpu0-krait-v3

--
viresh
