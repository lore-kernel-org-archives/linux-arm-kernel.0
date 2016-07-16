From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 16 Jul 2016 12:46:00 +0200
Subject: [PATCH 0/4] mmc: sunxi: Make sample clocks optional
Message-ID: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

It turns out that sun4i / sun5i do not have sample clocks at all,
so make them optional. Also remove the DDR capability when there
are no sample clocks because DDR modes do not work reliably without
them (observed on an UTOO P66 tablet with eMMC).

Ulf, can you please merge the first 2 patches, patches 3-4 should
be merged through Maxime's sunxi/dts tree, but not before the first
2 have hit linux-next.

Regards,

Hans
