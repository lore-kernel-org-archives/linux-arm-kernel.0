From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 15:55:56 +0100
Subject: [PATCH 0/2] imx-drm: two unbind bugs
Message-ID: <20140628145556.GG32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches fix a couple of oopses I've found while
re-testing the unbind support for imx-drm.

Can I suggest that people check that it's possible to successfully
unbind and rebind the driver when they add stuff (like the ipu plane
support)?

I have these queued for Greg to pull.  Thanks.

 drivers/staging/imx-drm/imx-ldb.c     | 3 +++
 drivers/staging/imx-drm/ipuv3-plane.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
