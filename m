From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 23 Jul 2013 09:26:34 -0400
Subject: [PATCH 1/5] ARM: keystone: remove redundant smp_init_cpus
 definition
In-Reply-To: <1374579164-30255-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374579164-30255-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <51EE848A.8050904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 July 2013 07:32 AM, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> arm_dt_init_cpu_maps is called before smp_init_cpus. It makes the
> platform/SoC definition of smp_init_cpus unnecessary.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
Looks good, thanks. I will pick this up.

Regards,
Santosh
