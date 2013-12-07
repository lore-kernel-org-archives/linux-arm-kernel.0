From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  7 Dec 2013 12:38:31 +0100
Subject: [PATCH 0/2] ARM: sunxi: Fix interrupt trigger types in the DT
Message-ID: <1386416313-703-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof,

It would be great if you could merge these two patches by the end of the 3.13
release cycle.

Thanks!
Maxime

Maxime Ripard (2):
  ARM: sun7i: dt: Fix interrupt trigger types
  ARM: sun6i: dt: Fix interrupt trigger types

 arch/arm/boot/dts/sun6i-a31.dtsi | 27 ++++++++++++++------------
 arch/arm/boot/dts/sun7i-a20.dtsi | 42 ++++++++++++++++++++--------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

-- 
1.8.4.2
