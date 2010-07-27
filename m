From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 27 Jul 2010 15:06:06 +0300
Subject: [PATCH 0/4] mx2_camera: mx25 fixes and enhancements
Message-ID: <cover.1280229966.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first 3 pathces in this series are fixes for the mx2_camera driver which is 
going upstream via the imx git tree. The last patch implements forced active 
buffer termination on mx25.

Baruch Siach (4):
  mx2_camera: fix a race causing NULL dereference
  mx2_camera: return IRQ_NONE when doing nothing
  mx2_camera: fix comment typo
  mx2_camera: implement forced termination of active buffer for mx25

 drivers/media/video/mx2_camera.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)
