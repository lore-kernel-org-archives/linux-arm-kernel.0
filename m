From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Sep 2016 09:33:38 +0200
Subject: [PATCH v2] arm64: defconfig: enable common modules for power
 management
In-Reply-To: <1472705469-25599-1-git-send-email-leo.yan@linaro.org>
References: <1472705469-25599-1-git-send-email-leo.yan@linaro.org>
Message-ID: <5498297.rN0szKFv4p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 1, 2016 12:51:09 PM CEST Leo Yan wrote:
> Enable common modules for power management; one is to enable
> CPUFREQ_DT driver; the driver is used by many platforms by passing OPP
> table from device tree.
> 
> Also enables thermal related drivers. Firstly we need enable
> configuration CPU_THERMAL for CPU cooling device driver, this will bind
> thermal zone with CPU cooling device; and enable 'power allocator'
> thermal governor.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 

Looks good,

Acked-by: Arnd Bergmann <arnd@arndb.de>

Catalin and Will: I never know who should merge this kind of patch
as we have a number of other arm64 defconfig patches going through
arm-soc, but this patch is not really platform specific.

Do you want to pick it up in the arm64 tree or should we take
this and others patches like it in general?

	Arnd
