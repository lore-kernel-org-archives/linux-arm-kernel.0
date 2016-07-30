From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 30 Jul 2016 16:25:43 +0200
Subject: [PATCH v2 0/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
Message-ID: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf, Maxime and Chen-Yu,

Here is v2 of my patch set to deal with sun4i / sun5i not having
mmc sample clocks, this time introducing a new sun7i-a20-mmc
compatible for the models which do have sample clks, as discussed
in the review of v1 of this set.

Ulf, can you please add patches 1-4 to your tree for 4.9, and
Maxime can you please pick up patch 5 ?

Thanks & Regards,

Hans
