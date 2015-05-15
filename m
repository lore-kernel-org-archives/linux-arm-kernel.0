From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Fri, 15 May 2015 21:50:05 +0200
Subject: [PATCH 0/2] ARM: /proc/atags: Export also for DT
In-Reply-To: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for DT "/atags" and stores ATAG structure to DT.

It depends on "ARM: /proc/cpuinfo: DT: Add support for Revision" patches.

Pali Roh?r (2):
  arm: devtree: Save atags if are in DT atags field
  arm: boot: store ATAG structure into DT atag field

 arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
 arch/arm/kernel/devtree.c               |    6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
1.7.9.5
