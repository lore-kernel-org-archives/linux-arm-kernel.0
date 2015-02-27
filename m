From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Fri, 27 Feb 2015 16:55:26 +0100
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <201502271645.58765@pali>
References: <201502271645.58765@pali>
Message-ID: <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for DT "/revision" and convert ATAG_REVISION to DT.

Pali Roh?r (2):
  arm: devtree: Set system_rev from DT revision
  arm: boot: convert ATAG_REVISION to DT revision field

 arch/arm/boot/compressed/atags_to_fdt.c |   37 +++++++++++++++++++++++++++++++
 arch/arm/kernel/devtree.c               |   20 ++++++++++++-----
 2 files changed, 52 insertions(+), 5 deletions(-)

-- 
1.7.9.5
