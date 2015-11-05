From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 5 Nov 2015 17:09:31 +0000
Subject: [PATCH 0/3] Xen wallclock on arm and arm64
Message-ID: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series introduces PV wallclock time support on arm and arm64.


Stefano Stabellini (3):
      xen/arm: introduce xen_read_wallclock
      xen/arm: introduce HYPERVISOR_dom0_op on arm and arm64
      xen/arm: set the system time in Xen via the XENPF_settime hypercall

 arch/arm/Kconfig                     |    1 +
 arch/arm/include/asm/xen/hypercall.h |    2 +
 arch/arm/xen/enlighten.c             |   82 ++++++++++++++++++++++++++++++++++
 arch/arm/xen/hypercall.S             |    1 +
 arch/arm64/xen/hypercall.S           |    1 +
 5 files changed, 87 insertions(+)


Cheers,

Stefano
