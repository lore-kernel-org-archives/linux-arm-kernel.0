From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 24 Nov 2016 16:13:38 +0000
Subject: [PATCH v2 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
In-Reply-To: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1480004021-4037-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds CAN and CAN FD support to the r8a7796.

Changes since v1:
- Split device tree changes from bindings documentation.
- Rebased on renesas-devel-20161123v2-v4.9-rc6.


Chris Paterson (3):
  arm64: dts: r8a7796: Add CAN external clock support
  arm64: dts: r8a7796: Add CAN support
  arm64: dts: r8a7796: Add CAN FD support

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

-- 
1.9.1
