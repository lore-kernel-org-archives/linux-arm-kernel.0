From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 21 Oct 2013 11:46:04 +0100
Subject: [PATCH v2 0/5] ARM: vexpress/TC2: cpufreq support
In-Reply-To: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1382352364.3332.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-10-21 at 10:58 +0100, Sudeep KarkadaNagesha wrote:
> Sudeep KarkadaNagesha (5):
>   cpufreq: arm-big-little: use clk_get instead of clk_get_sys
>   ARM: vexpress/TC2: add support for CPU DVFS
>   ARM: vexpress/TC2: add cpu clock support
>   cpufreq: arm_big_little: add vexpress SPC interface driver
>   ARM: vexpress/TC2: register vexpress-spc cpufreq device
> 
>  arch/arm/mach-vexpress/Kconfig         |  12 ++
>  arch/arm/mach-vexpress/Makefile        |   3 +-
>  arch/arm/mach-vexpress/spc.c           | 366 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-vexpress/spc.h           |   2 +-
>  arch/arm/mach-vexpress/tc2_pm.c        |   7 +-

For the vexpress bits and pieces:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawe?
