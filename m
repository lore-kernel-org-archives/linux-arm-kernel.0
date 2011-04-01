From: aviksil@linux.vnet.ibm.com (Avik Sil)
Date: Fri, 01 Apr 2011 20:03:40 +0530
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Message-ID: <4D95E244.1050400@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've applied the patches in 
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html 
on top of a linaro kernel which resulted in booting problem on 
Pandaboard. It hangs inside the cti_unlock() while reading the 
LOCKSTATUS value, which happens when omap_init_pmu() is called. Please 
help me debug the issue.

Regards,
Avik
