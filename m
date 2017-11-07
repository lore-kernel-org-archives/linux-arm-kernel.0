From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 7 Nov 2017 11:45:40 +0530
Subject: [PATCH v4 19/20] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
In-Reply-To: <1509720477-18936-20-git-send-email-sudeep.holla@arm.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-20-git-send-email-sudeep.holla@arm.com>
Message-ID: <20171107061540.GB3297@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-11-17, 14:47, Sudeep Holla wrote:
> On some ARM based systems, a separate Cortex-M based System Control
> Processor(SCP) provides the overall power, clock, reset and system
> control including CPU DVFS. SCMI Message Protocol is used to
> communicate with the SCP.
> 
> This patch adds a cpufreq driver for such systems using SCMI interface
> to drive CPU DVFS.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  MAINTAINERS                    |   2 +-
>  drivers/cpufreq/Kconfig.arm    |  11 ++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/scmi-cpufreq.c | 274 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 287 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpufreq/scmi-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
