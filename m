From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Feb 2013 12:26:04 +0000
Subject: [PATCH] ARM: Allow modules to read cpu_logical_map
In-Reply-To: <1360325980-19089-1-git-send-email-dave.martin@linaro.org>
References: <1360325980-19089-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20130208122604.GO17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 12:19:40PM +0000, Dave Martin wrote:
> It is reasonable for loadable modules to be CPU topology aware
> (particular examples include cpufreq and cpuidle drivers).
> 
> This patch exports a new function cpu_get_hwid(cpu) to provide
> suitable read-only access outside vmlinux.

And we have an export with no user... where are the patches which
illustrate its usage?
