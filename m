From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 21 Jan 2014 18:13:28 +0200
Subject: [PATCH 0/4] ARM: dts: cm-fx6: extend board support
Message-ID: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend support for cm-fx6 (Utilite) board.
Add SATA, USB OTG, and USB Host port 1 support.

Igor Grinberg (4):
  ARM: dts: cm-fx6: rearrange the dts file
  ARM: dts: cm-fx6: add SATA support
  ARM: dts: cm-fx6: add support for USB OTG
  ARM: dts: cm-fx6: add support for USB host port 1

 arch/arm/boot/dts/imx6q-cm-fx6.dts | 77 ++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 11 deletions(-)

-- 
1.8.3.2
