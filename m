From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 6 Apr 2016 14:15:19 +0530
Subject: [PATCH v3] arm: omap2: remove redundant multiplatform checks
In-Reply-To: <1459930448-32638-1-git-send-email-ve92mose@stud.informatik.uni-erlangen.de>
References: <201604060526.ouhQYqrT%fengguang.wu@intel.com>
 <1459895738-6546-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <1459930448-32638-1-git-send-email-ve92mose@stud.informatik.uni-erlangen.de>
Message-ID: <5704CC9F.6010502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Tony

On Wednesday 06 April 2016 01:44 PM, Jonas Rabenstein wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> The directory arch/arm/mach-omap2 is only selected for compilation if
> CONFIG_ARCH_OMAP2PLUS is selected. CONFIG_ARCH_OMAP2PLUS itself is a
> silent option and all machines selecting this option are multiplatform
> devices. As a consequence checks for CONFIG_ARCH_MULTIPLATFORM as well
> as CONFIG_ARCH_OMAP2PLUS within that directory are superfluous and can
> be removed.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
