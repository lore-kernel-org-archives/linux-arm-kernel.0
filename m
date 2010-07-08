From: pieterg@gmx.com (pieterg)
Date: Thu, 8 Jul 2010 19:03:53 +0200
Subject: [PATCH 0/5] colibri-pxa3xx patches
Message-ID: <201007081903.53444.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a bit more colibri pxa300/310 support

1/5: cpufreq-pxa3xx: use HSIO 312MHz on the pxa310
This one more or less depends on Marek Vasut's HSIO bus x24 multiplier patch 
which defines 312MHz as valid HSIO frequency.
(without this x24 multiplier, pxafb will make wrong pixelclock calculations)

2/5: colibri-pxa300: fix ac97 init on pxa310

3/5: colibri-pxa300: add uart support

4/5: colibri-pxa3xx: add i2c support

5/5: colibri-pxa3xx: add touchscreen support

Rgds, Pieter
