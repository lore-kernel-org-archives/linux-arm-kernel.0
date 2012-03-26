From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon, 26 Mar 2012 15:17:45 +0200
Subject: [PATCH v2 0/3] media: tvp5150: Fix mbus format to UYUV instead of
 YUYV.
Message-ID: <1332767868-2531-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
- Swap order of patches 3 and 4 to make the series bisectable.

[PATCH v2 1/3] media: tvp5150: Fix mbus format.
[PATCH v2 2/3] i.MX27: visstrim_m10: Remove use of MX2_CAMERA_SWAP16.
[PATCH v2 3/3] media: mx2_camera: Fix mbus format handling.
