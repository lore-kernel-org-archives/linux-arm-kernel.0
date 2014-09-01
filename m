From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Sep 2014 18:07:12 +0100
Subject: [PATCH 0/2] Two imx-drm oops fixes
Message-ID: <20140901170712.GJ30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Here's two oops fixes for imx-drm, which I've had queued up for a number
of months now.  Shawn posted different fixes for the same oops recently
as well.

 drivers/staging/imx-drm/imx-ldb.c     | 3 +++
 drivers/staging/imx-drm/ipuv3-plane.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
