From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 10 Sep 2013 22:07:04 +0200
Subject: [PATCH 0/4] cpufreq: fixes for v3.12
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <2170660.Fok0qj9HIB@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 10, 2013 06:59:45 PM Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi Shawn, Guennadi,

Hi,

Thanks for the fixes, ->

> These are the fixes for the issue reported by Guennadi.
> cpu_dev should point to cpu0 device instead of cpufreq-cpu0 platform
> devices. The dev_id is also updated while registering the cpu clocks.
> 
> Can you review these ? Tested-by is much appreciated as I don't
> have hardware to check the fix.

-> but I'll wait for ACKs and Tested-by replies before taking them.

Thanks,
Rafael
