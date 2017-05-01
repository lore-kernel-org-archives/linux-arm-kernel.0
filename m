From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  1 May 2017 11:14:06 +0800
Subject: [PATCH v2 0/2] ARM: sun8i: a83t: device tree cleanup
Message-ID: <20170501031408.10469-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here's v2 of the A83T device tree cleanup patches. I dropped the change
to the uart device node name for now.

Also added a second patch changing the underscores in device node names
I just added to hyphens. AFAIK that is the preferred naming scheme.
Please squash it into "ARM: sun8i: a83t: Rename pinmux setting names".


Regards
ChenYu

Chen-Yu Tsai (2):
  ARM: sun8i: a83t: Drop leading zeroes from device node addresses
  ARM: sun8i: a83t: Replace underscores with hyphens in pinmux node
    names

 arch/arm/boot/dts/sun8i-a83t.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.11.0
