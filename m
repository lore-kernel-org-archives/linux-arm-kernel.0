From: richard.zhao@freescale.com (Richard Zhao)
Date: Sun, 1 Apr 2012 09:20:58 +0800
Subject: [PATCH 0/2] change lpj in arm smp common code
In-Reply-To: <87sjhtec0w.fsf@ti.com>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
 <87sjhtec0w.fsf@ti.com>
Message-ID: <20120401012057.GC2603@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 10:21:19AM -0800, Kevin Hilman wrote:
> Richard Zhao <richard.zhao@linaro.org> writes:
> 
> > The two patches were originally in [PATCH V6 0/7] add a generic cpufreq driver.
> > I seperated them and hope they can go to upstream earlier.
> >
> > Richard Zhao (2):
> >   ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
> >   cpufreq: OMAP: remove loops_per_jiffy recalculate for smp
> 
> The first one should go into Russell's patch system.  Once he queues
> that, I can queue the OMAP one for the CPUfreq maintainer.
Hi Russel & Kevin,

Could you double check whether you've picked the patch searies?
I can not find them in 3.4rc.

Thanks
Richard
> 
> Kevin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
