From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 12 Sep 2013 00:58:54 +0200
Subject: [PATCH 0/4] cpufreq: fixes for v3.12
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1795989.18GOYqdUtX@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 10, 2013 06:59:45 PM Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi Shawn, Guennadi,
> 
> These are the fixes for the issue reported by Guennadi.
> cpu_dev should point to cpu0 device instead of cpufreq-cpu0 platform
> devices. The dev_id is also updated while registering the cpu clocks.
> 
> Can you review these ? Tested-by is much appreciated as I don't
> have hardware to check the fix.

I have a little problem with this series, because the last patch is based
on the current Linus' tree rather than on my master branch which is what
I have ready to push.  I don't think it makes sense to rebase it, however,
because that would introduce a merge conflict for Linus unnecessarily.

To avoid merging stuff back and forth, I'll push this series later in the
cycle.

Thanks,
Rafael
