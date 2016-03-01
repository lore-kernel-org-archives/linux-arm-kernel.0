From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 01 Mar 2016 03:00:22 +0100
Subject: [PATCH 1/2] cpufreq: qoriq: allow building as module with
 THERMAL=m
In-Reply-To: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
References: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
Message-ID: <4312477.lDX3yCWWFs@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 29, 2016 05:04:20 PM Arnd Bergmann wrote:
> My previous patch to avoid link errors with the qoriq cpufreq
> driver disallowed all of the broken cases, but also prevented
> the driver from being built when CONFIG_THERMAL is a module.
> 
> This changes the dependency to allow the cpufreq driver to
> also be a module in this case, just not built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cpufreq: qoriq depends on thermal
> ---
> 
> If possible, please fold this change directly into the previous
> commit

Done.

I've applied the [2/2] too.

Thanks,
Rafael
