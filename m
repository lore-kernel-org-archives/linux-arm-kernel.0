From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 19 Jul 2012 20:39:39 +0200
Subject: [PATCH 0/3] Add a generic cpufreq-cpu0 driver
In-Reply-To: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201207192039.40213.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday, July 19, 2012, Shawn Guo wrote:
> This is a continuous effort of Richard's work [1].  But that generic
> cpufreq driver has been rewritten with taking omap-cpufreq.c as the
> reference to adopt OPP library.
> 
> Same as Richard's patch, the driver has no intention to support the
> multi-core systems that frequency and voltage can be scaled
> independently on different CPUs.  Instead, it aims at uniprocessor (UP)
> and those symmetric multiprocessor (SMP) systems which share clock and
> voltage across all CPUs.
> 
> I have seen patch from Mike changing omap-cpufreq driver to scale
> regulator from clk notifier.  We can definitely make the same move
> for cpufreq-cpu0 later when the patch gets accepted.
> 
> Regards,
> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.kernel.cpufreq/7688/focus=7688

It is too late to consider your patches for inclusion into v3.6, so I'm
regarding them as RFC at this point.

Please resubmit after v3.6-rc1 has been released.

Thanks,
Rafael
