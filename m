From: jonathar@broadcom.com (Jonathan Richardson)
Date: Mon, 2 Mar 2015 14:41:09 -0800
Subject: [PATCH RESEND 0/1] Enable Broadcom Cygnus BCM958305K
In-Reply-To: <Jonathan Richardson <jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
Message-ID: <1425336070-3414-1-git-send-email-jonathar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a DTS file to enable the BCM58305 Wireless Audio reference
design based on Cygnus. It will be kept up to date as Cygnus drivers are
accepted into the mainline.

Jonathan Richardson (1):
  ARM: dts: Enable Broadcom Cygnus BCM958305K

 arch/arm/boot/dts/Makefile       |    3 ++-
 arch/arm/boot/dts/bcm958305k.dts |   53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm958305k.dts

-- 
1.7.9.5
