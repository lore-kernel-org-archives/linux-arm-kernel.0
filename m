From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 18 Jun 2016 11:28:06 +0200
Subject: [PATCH v5 0/4] usb: musb: sunxi: Fixes + peripheral-only mode
Message-ID: <1466242090-22264-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

I noticed that you've merged a phy-sun4i-usb fix into your linux-phy/fixes
branch, this caused a conflict in the 3th patch of this set, so I'm
posting a new rebased version here.

Since these patches depend on each other and now also depend on changes
in your fixes branch, can you please merge all 4 for next through your
tree?

Thanks & Regards,

Hans
