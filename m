From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Sep 2013 10:23:45 +0800
Subject: [PATCH 0/4] cpufreq: fixes for v3.12
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130911022343.GJ5815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 06:59:45PM +0100, Sudeep KarkadaNagesha wrote:
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

For IMX,

Tested-by: Shawn Guo <shawn.guo@linaro.org>
