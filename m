From: plaes@plaes.org (Priit Laes)
Date: Fri, 11 Dec 2015 23:22:59 +0200
Subject: [PATCH] ARM: dts: sun4i: gemei-g9: Enable PA GPIO pin configuration
Message-ID: <1449868980-28237-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PA GPIO pin (PH15) controls power to external amplifier (FT2012Q).

This patch depends on 'ASoC: sun4i-codec: Add support for PA gpio pin'
authored by Hans de Goede.

Priit Laes (1):
  ARM: dts: sun4i: gemei-g9: Enable PA GPIO pin configuration

 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.6.4
