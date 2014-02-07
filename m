From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Feb 2014 16:21:48 +0100
Subject: [PATCH v4 0/5] clk: sunxi usb clks support
Message-ID: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

And here is v4 of my sunxi usb clks support series.

Changes since v2:
-rename the compatibilty strings from foo-usb-gates-clk to foo-usb-clk

Changes since v3:
-rename the compatibilty string for sun4i-usb-clk to sun4i-a10-usb-clk

Note the dts bits (patches 3-5) of this series depends on Chen-Yu Tsai's clk
rename series.

Emilio, should Mike pick patches 1-2 up directly, or should they go through
your tree?

Maxime, can you please add patches 3-5 to your dts tree ? Assuming that
wens clk rename patches are already there.

Thanks & Regards,

Hans
