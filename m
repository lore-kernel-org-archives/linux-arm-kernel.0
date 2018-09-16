From: beagleboard@davidjohnsummers.uk (David Summers)
Date: Sun, 16 Sep 2018 19:16:33 +0100
Subject: [PATCH] Device Tree for ASUS Tinker Board S (v2)
Message-ID: <20180916181636.7938-1-beagleboard@davidjohnsummers.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Heiko for comments on the first

The tinkerboard S is an ASUS device, it is similar to the tinker board
but with an eMMC chip, which needs enabling in the device tree.

This patch is split into 3 parts
1) It creates a common include file rk3288-tinker.dtsi and sets up
rk3288-tinker.dts and rk3288-tinker-s.dts to do device trees for the two boards
2) It patches the rk3288-tinker-s.dts to enable eMMC
3) It patches the rk3299-tinker-s.dts to enable WiFi and Bluetooth

I'm not sure if the wifi should be common for both boards (so in the dtsi)
But am sure its needed to enable wifi on the S variant.

I have asked for the dtb to be tested - but sending these patches anyway
to get comments back.

Regards

David Summers
signed-off: "David Summers" <beagleboard@davidjohnsummers.uk>
