From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 May 2018 09:25:34 -0700
Subject: [PATCH v3 00/15] ARM Spectre variant 2 fixes
In-Reply-To: <20180525135938.GE17671@n2100.armlinux.org.uk>
References: <20180525135938.GE17671@n2100.armlinux.org.uk>
Message-ID: <20180525162534.GE98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180525 07:02]:
> Third version:
> - Remove "PSCI" from the SMC version of the workaround as well.
> - Avoid reporting active workaround if the IBE bit is not set.
> - Only probe for workaround_1 on Cortex A57 and A72, or non-ARM CPUs.
> - Require features probe for workaround_1 to return zero.
> - Validation that all CPUs in the system have the same workaround status.
> - Avoid corrupting r12 in workaround_1 KVM hypervisor implementation.

Looks good to me and things still work for me. I don't really
want to count that as Tested-by though :) But feel free to add:

Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
