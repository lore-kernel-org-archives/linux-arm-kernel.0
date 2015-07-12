From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 11 Jul 2015 18:35:06 -0700
Subject: [PATCH] ARM: BCM63xx: fix parameter to of_get_cpu_node in
 bcm63138_smp_boot_secondary
In-Reply-To: <1436549771-6097-1-git-send-email-sudeep.holla@arm.com>
References: <1436549771-6097-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <55A1C44A.9070905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/10/15 10:36, Sudeep Holla a ?crit :
> of_get_cpu_node provides the device node associated with the given
> logical CPU and cpu_logical_map contains the physical id for each CPU
> in the logical ordering. Passing cpu_logical_map(cpu) to of_get_cpu_node
> is incorrect.
> 
> This patch fixes the issue by passing the logical CPU number to
> of_get_cpu_node
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied to soc/next, with the proper Fixes tag for this, thanks!
-- 
Florian
