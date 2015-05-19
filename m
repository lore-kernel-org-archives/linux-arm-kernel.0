From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Wed, 20 May 2015 00:10:57 +0300
Subject: [PATCH v4 0/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <20150506140534.GC10890@lunn.ch>
Message-ID: <1432069858-10958-1-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased against 4.1-rc1
Sorry for the long delay with the respin, I've been caught in the usual 
daily routine yet again.
Hopefully everything's finally okay now.

Changelog since last respin: 
* Properly initialize phy registers in dts

Andrew Andrianov (1):
  ARM: mvebu: dts: Add dts file for DLink DNS-327L

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts | 356 +++++++++++++++++++++++++
 2 files changed, 357 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts

-- 
2.1.4
