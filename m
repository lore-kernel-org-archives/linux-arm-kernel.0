From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Thu,  5 Oct 2017 10:58:17 +0200
Subject: [PATCH 0/3] ARM: dts: gr-peach: Mix DTS fixes/updates
Message-ID: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   this series includes three patches for GR-Peach DTS.

The first, very trivial one is the re-proposal of the already sent patch, with
the commit message updated as suggested by Sergei.

The second just enables the Multi-function timer/counter unit which was
disabled and is actually used for timer event generations and wake-ups.

After enabling the MTU unit, ETHER is now working properly, so I am re-proposing
this patch, which had been left out from previous gr-peach DTS series because
the interface was not working correctly.

Thanks
   j

Jacopo Mondi (3):
  ARM: dts: gr-peach: Fix 'leds' node name indent
  ARM: dts: gr-peach: Enable MTU2 timer pulse unit
  ARM: dts: gr-peach: Add ETHER pin group

 arch/arm/boot/dts/r7s72100-gr-peach.dts | 44 ++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

--
2.7.4
