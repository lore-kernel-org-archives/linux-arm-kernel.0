From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 16:35:27 +0530
Subject: [PATCH] Add ability for PXA2xx CPUFreq to be compiled as a module
 or, not at all
In-Reply-To: <5472AD1E.8010005@tul.cz>
References: <5472AD1E.8010005@tul.cz>
Message-ID: <CAOh2x==+amATsYbASxr8D6z5x3UOxySLY_kNXzDvoSB4_tycAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 9:29 AM, Petr Cvek <petr.cvek@tul.cz> wrote:
> Add ability for PXA2xx CPUFreq to be compiled as a module or not at all.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  drivers/cpufreq/Kconfig.arm | 8 ++++++++
>  drivers/cpufreq/Makefile    | 3 +--
>  2 files changed, 9 insertions(+), 2 deletions(-)

Make sure you cc Maintainers to get quick responses.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
