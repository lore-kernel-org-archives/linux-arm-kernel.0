From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Aug 2013 21:35:29 -0300
Subject: imx-ldb: "mx-ldb ldb.10: adding encoder failed with -16"
Message-ID: <CAOMZO5CjgfRLfcgRjO2eAx4ZQkZNHVe7tLqeCacJndTJiDGg_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Running next-20130827 I get the following probe failure on mx6:

[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
[drm] Initialized imx-drm 1.0.0 20120507 on minor 0
imx-ldb ldb.10: adding encoder failed with -16
imx-ldb: probe of ldb.10 failed with error -16
imx-ipuv3 2400000.ipu: IPUv3H probed
imx-ipuv3 2800000.ipu: IPUv3H probed
imx-ipuv3-crtc imx-ipuv3-crtc.0: adding crtc failed with -16.
imx-ipuv3-crtc: probe of imx-ipuv3-crtc.0 failed with error -16
imx-ipuv3-crtc imx-ipuv3-crtc.1: adding crtc failed with -16.
mmc0: new SDHC card at address b5a1
mmcblk0: mmc0:b5a1 SD04G 3.69 GiB
imx-ipuv3-crtc: probe of imx-ipuv3-crtc.1 failed with error -16
 mmcblk0: p1
imx-ipuv3-crtc imx-ipuv3-crtc.2: adding crtc failed with -16.
imx-ipuv3-crtc: probe of imx-ipuv3-crtc.2 failed with error -16
imx-ipuv3-crtc imx-ipuv3-crtc.3: adding crtc failed with -16.
imx-ipuv3-crtc: probe of imx-ipuv3-crtc.3 failed with error -16

I haven't started debugging it yet, but just wanted to know if someone
has already seen this problem or have any suggestions.

Regards,

Fabio Estevam
