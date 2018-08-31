From: peda@axentia.se (Peter Rosin)
Date: Fri, 31 Aug 2018 22:44:01 +0200
Subject: [PATCH 0/2] ARM: dts: at91: nattis/tse850: drop 3 indentation levels
Message-ID: <20180831204403.14653-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I just noticed that the pinctrl and watchdog nodes in sama5d3.dtsi have
gained labels, something which I have had a plan to add myself at some
point. But now that they are here, I just have to make use of them...

Cheers,
Peter

Peter Rosin (2):
  ARM: dts: at91: nattis: drop three indentation levels
  ARM: dts: at91: tse850: drop three indentation levels

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 72 ++++++++++++-----------------
 arch/arm/boot/dts/at91-tse850-3.dts         | 32 ++++++-------
 2 files changed, 43 insertions(+), 61 deletions(-)

-- 
2.11.0
