From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Aug 2018 13:03:41 -0700
Subject: [PATCH 0/3] ARM: NSP updates to support switch interrupts/SFP
Message-ID: <20180827200344.16158-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series updates the ARM NSP DTS and BCM958625HR in order to
support the SFP connected to port 5 on these reference boards.

I will be submitting the functional changes to drivers/net/dsa/b53 once
net-next opens back up, but this is largely independent from getting
these 3 patches out.

Thank you

Florian Fainelli (3):
  ARM: dts: NSP: Enable SFP on bcm958625hr
  dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
  ARM: dts: NSP: Wire up switch interrupts

 .../devicetree/bindings/net/dsa/b53.txt       | 23 ++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi                | 31 ++++++++++++++++++-
 arch/arm/boot/dts/bcm958625hr.dts             | 29 +++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.17.1
