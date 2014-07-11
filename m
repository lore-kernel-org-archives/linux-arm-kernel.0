From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Jul 2014 14:44:07 +0530
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
Message-ID: <CAKohpokGOtdY2SyJuN1QcVoDy2wsMcveiyr1e4cr0oe2j__h5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2014 14:42, Peter De Schrijver <pdeschrijver@nvidia.com> wrote:
> I don't think that's going to work? The voltage scaling is handled in hw.

Ahh..

> cpufreq-cpu0 seems to assume explicit sw control of the vdd_cpu regulator?

Its optional. If it fails to find a regulator, it doesn't depend or
play with it.
