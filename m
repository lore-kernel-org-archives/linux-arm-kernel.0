From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jan 2014 23:46:18 +0100
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
Message-ID: <1389393980-21183-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v4 of my ohci and ehci-platform clks, phy and dt support patch-set,
this version should be 100% ready for merging upstream.

Changes since v3:
-Address all of Alan Stern's review comments
-Properly use put_clk in probe error path
-Don't do hcd_put until after power_off as power_off may use private hcd data

Regards,

Hans
