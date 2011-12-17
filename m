From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 17 Dec 2011 15:57:34 +0800
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <201112161226.04092.heiko@sntech.de>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
 <201112161226.04092.heiko@sntech.de>
Message-ID: <20111217075732.GB2010@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 12:26:03PM +0100, Heiko St?bner wrote:
> Am Freitag, 16. Dezember 2011, 11:30:59 schrieb Richard Zhao:
> > It support single core and multi-core ARM SoCs. But it assume
> > all cores share the same frequency and voltage.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm   |    8 ++
> >  drivers/cpufreq/Makefile      |    1 +
> >  drivers/cpufreq/arm-cpufreq.c |  269
> > +++++++++++++++++++++++++++++++++++++++++ 3 files changed, 278
> > insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/cpufreq/arm-cpufreq.c
> 
> looks quite cool, but should also provide a description of the devicetree 
> bindings (i.e. like the rest in Documentation/devicetree/bindings/...) for 
> future reference.
Yes, Thanks for your remind.
> 
> Heiko
> 
