From: nitin.garg@freescale.com (Nitin Garg)
Date: Mon, 31 Mar 2014 15:34:31 -0500
Subject: [PATCH] workaround Cortex-A9 errata 761320 and 794072
Message-ID: <1396298072-13254-1-git-send-email-nitin.garg@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements workaround for 2 Cortex-A9 erratas.

Nitin Garg (1):
  ARM: errata: workaround Cortex-A9 errata 761320 and 794072

 arch/arm/Kconfig          |   23 +++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig |    2 ++
 arch/arm/mm/proc-v7.S     |   11 +++++++++++
 3 files changed, 36 insertions(+), 0 deletions(-)

-- 
1.7.4.1
