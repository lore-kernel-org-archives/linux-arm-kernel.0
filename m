From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 May 2018 11:04:50 -0700
Subject: [PATCH 0/3] Initial Spectre variant 1 patches
In-Reply-To: <20180531133047.GS17671@n2100.armlinux.org.uk>
References: <20180531133047.GS17671@n2100.armlinux.org.uk>
Message-ID: <20180531180450.GT5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180531 13:34]:
> Hi,
> 
> This series adds initial support for the Spectre variant 1 workarounds
> to the kernel.  This does _not_ cover the user accessors, which are
> still in development.
> 
> The series adds support for the array_index_mask_nospec() macro, used
> by generic kernel code to mask out of bounds pointers, and also adds
> the syscall table hardening.

For the series including v2 patch of 3/3:

Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
