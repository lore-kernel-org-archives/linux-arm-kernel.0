From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Nov 2014 14:38:06 +0100
Subject: [PATCH v2 0/9] sun6i / A31 ir receiver support
Message-ID: <1416749895-25013-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my sun6i ir receiver support patch-set as with v1, this
touches clk, mfd (for the prcm clks), dts and media/rc code.

Changes in v2:
-"clk: sunxi: Give sunxi_factors_register a registers parameter"
 -Updated commit message to mention the removal of __init
 -Add error checking to calls of of_iomap
-"rc: sunxi-cir: Add support for an optional reset controller"
 -Document resets property in devicetree bindings doc

Regards,

Hans
