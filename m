From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 17 Dec 2017 19:08:53 +0100
Subject: [PATCH v4 3/4] cpufreq: Add DVFS support for Armada 37xx
In-Reply-To: <20171214153631.GZ3322@vireshk-i7>
References: <20171214150006.25438-1-gregory.clement@free-electrons.com>
 <20171214150006.25438-4-gregory.clement@free-electrons.com>
 <20171214153631.GZ3322@vireshk-i7>
Message-ID: <2201504.Sp2n0UgIp2@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 14, 2017 4:36:31 PM CET Viresh Kumar wrote:
> On 14-12-17, 16:00, Gregory CLEMENT wrote:
> > This patch adds DVFS support for the Armada 37xx SoCs
> > 
> > There are up to four CPU frequency loads for Armada 37xx controlled by
> > the hardware.
> > 
> > This driver associates the CPU load level to a frequency, then the
> > hardware will switch while selecting a load level.
> > 
> > The hardware also can associate a voltage for each level (AVS support)
> > but it is not yet supported
> > 
> > Tested-by: Andre Heider <a.heider@gmail.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> >  drivers/cpufreq/Kconfig.arm           |   7 +
> >  drivers/cpufreq/Makefile              |   1 +
> >  drivers/cpufreq/armada-37xx-cpufreq.c | 241 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 drivers/cpufreq/armada-37xx-cpufreq.c
> 
> Thanks for taking care of very minor review comments I had. All the
> patches look good now to me :)

All applied, thanks!
