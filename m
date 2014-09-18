From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Sep 2014 10:16:51 -0700
Subject: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Message-ID: <20140918171650.GK14505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140901 11:09]:
> Hi,
> 
> This set contains PRCM related cleanups meant for 3.18 merge window.
> These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
> (http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nishanth's
> set is used as basis to avoid merge issues.
> 
> Purpose of this work is to eventually convert the PRCM code into a
> separate driver, but this is done in incremental parts as the amount
> of changes is substantial. Expected conclusion of this work is 3.19
> if everything goes fine.
> 
> This part of the work mostly moves some of the SoC specific PRCM driver
> calls under generic version of the same, and adds SoC-ops to support
> these on the driver level.
> 
> Working branch posted here:
> 
> tree: https://github.com/t-kristo/linux-pm.git
> branch: for-v3.18/prcm-cleanup

Paul, any comments on this series?

Regards,

Tony
 
> Testing done:
> am335x-evm: boot
> am335x-bone: boot
> am335x-boneblack: boot
> am3517-evm: boot
> am437x-gp-evm: boot
> omap3-beagle-xm: boot
> omap3-beagle: boot suspend/resume (ret/off)
> dra7-evm: boot (with additional clock patches to fix boot issues)
> omap3-n900: boot
> omap5-uevm: boot
> omap4-panda-es: boot suspend/resume (ret)
> omap2430-sdp: boot
> 
> -Tero
> 
