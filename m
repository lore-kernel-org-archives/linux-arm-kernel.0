From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Jul 2013 19:59:57 -0400
Subject: [PATCH] ARM: omap2: Only select errata 798181 if SMP
In-Reply-To: <1374710324-24347-1-git-send-email-olof@lixom.net>
References: <1374710324-24347-1-git-send-email-olof@lixom.net>
Message-ID: <51F06A7D.4020201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 July 2013 07:58 PM, Olof Johansson wrote:
> Avoids the following warning when SMP is off:
> 
> warning: (ARCH_KEYSTONE && SOC_OMAP5) selects ARM_ERRATA_798181 which
> has unmet direct dependencies (CPU_V7 && SMP)
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Since this is trivial I've already applied it to fixes on arm-soc.
> 
yep.

Regards,
Santosh
