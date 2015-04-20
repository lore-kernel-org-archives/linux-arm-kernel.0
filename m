From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 20 Apr 2015 20:31:50 +0200
Subject: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
Message-ID: <1429554710.14597.41.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-04-20 at 09:17 -0500, Josh Cartwright wrote:
> On Mon, Apr 20, 2015 at 05:27:26PM +0800, pi-cheng.chen wrote:
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
>   
> > +config ARM_MT8173_CPUFREQ
> > +	bool "Mediatek MT8173 CPUFreq support"
> > +	depends on ARCH_MEDIATEK && REGULATOR
> 
> I think you want to 'select REGULATOR' here; because REGULATOR isn't
> a user-visible option.

REGULATOR is user visible, at least in next-20150420.

> > +	help
> > +	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.

Thanks,


Paul Bolle
