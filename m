From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 13 May 2018 10:48:04 +0200
Subject: [PATCH V3 0/3] cpufreq: dt: Allow platforms to provide
 suspend/resume hooks
In-Reply-To: <cover.1524561482.git.viresh.kumar@linaro.org>
References: <cover.1524561482.git.viresh.kumar@linaro.org>
Message-ID: <2141918.GL8YPaupJ4@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 24, 2018 11:39:44 AM CEST Viresh Kumar wrote:
> Hi Rafael,
> 
> These patches are already tested by Miquel and are ready to get merged.
> Please pick them as part of 4.18 stuff whenever you do that.
> 
> I have updated the cpufreq-dt driver to allow platform specific
> suspend/resume hooks and done some minor cleanup in the driver. I have
> updated Miquel's patch and applied that on top of all this.
> 
> Thanks.
> 
> V2->V3:
> - Don't double put the clock.
> - Fix commit log of 3/3.
> - Add tested-by from Miquel.
> - There was no V2 of 1-2/3 but only 3/3 on the lists. All are marked as
>   V3 to clear things out.
> 
> --
> viresh
> 
> [1] https://lkml.kernel.org/r/20180421141943.25705-1-miquel.raynal at bootlin.com
> 
> Miquel Raynal (1):
>   cpufreq: add suspend/resume support in Armada 37xx DVFS driver
> 
> Viresh Kumar (2):
>   cpufreq: dt: Allow platform specific suspend/resume callbacks
>   cpufreq: armada: Free resources on error paths
> 
>  drivers/cpufreq/armada-37xx-cpufreq.c | 100 +++++++++++++++++++++++++++++-----
>  drivers/cpufreq/cpufreq-dt.c          |  10 +++-
>  drivers/cpufreq/cpufreq-dt.h          |   5 ++
>  3 files changed, 100 insertions(+), 15 deletions(-)
> 
> 

Applied including the v4 of patch [3/3], thanks!
