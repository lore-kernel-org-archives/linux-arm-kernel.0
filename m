From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 26 Jul 2012 13:20:33 +0200
Subject: [PATCH 0/4] Fix clocks for i.MX27 in mx2_camera.c
Message-ID: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series follows the steps purposed by Guennadi
(http://www.spinics.net/lists/arm-kernel/msg185555.html) in
order to fix clock handlings for i.MX27 in mx2_camera.c

[PATCH 1/4] i.MX27: Fix emma-prp and csi clocks.
[PATCH 2/4] media: mx2_camera: Mark i.MX25 support as BROKEN.
[PATCH 3/4] Schedule removal of i.MX25 support in mx2_camera.c
[PATCH 4/4] media: mx2_camera: Fix clock handling for i.MX27.
