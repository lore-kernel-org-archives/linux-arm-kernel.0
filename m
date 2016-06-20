From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Jun 2016 16:09:56 +0200
Subject: [PULL] drm/bridge: sii902x driver
Message-ID: <20160620160956.438e1c17@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

This pull request contains 2 patches adding support for the sii902x
bridge.

Regards,

Boris

The following changes since commit a0877f52035280370707bdefeddc6faa6478b892:

  Merge tag 'topic/drm-misc-2016-06-15' of git://anongit.freedesktop.org/drm-intel into drm-next (2016-06-16 05:49:32 +1000)

are available in the git repository at:

  git at github.com:bbrezillon/linux-at91.git tags/drm-sii902x

for you to fetch changes up to b7eaa9ffa6a44c4efabdd9d430e882d67c92c5e8:

  drm/bridge: Add sii902x DT bindings doc (2016-06-20 15:57:06 +0200)

----------------------------------------------------------------
Add basic support for the sii902x RGB -> HDMI bridge.

----------------------------------------------------------------
Boris Brezillon (2):
      drm/bridge: Add sii902x driver
      drm/bridge: Add sii902x DT bindings doc

 Documentation/devicetree/bindings/display/bridge/sii902x.txt |  35 +++++++++++++
 drivers/gpu/drm/bridge/Kconfig                               |   8 +++
 drivers/gpu/drm/bridge/Makefile                              |   1 +
 drivers/gpu/drm/bridge/sii902x.c                             | 467 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	+++++++++++++++++++++++++
 4 files changed, 511 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/sii902x.txt
 create mode 100644 drivers/gpu/drm/bridge/sii902x.c
