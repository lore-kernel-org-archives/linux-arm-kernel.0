From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed, 23 Nov 2011 16:13:45 +0100
Subject: [PATCH v3 0/2] Add support form eMMa-PrP in i.MX2 chips as a mem2mem
 device.
Message-ID: <1322061227-6631-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX2x SoCs have a PrP which is capable of resizing and format
conversion of video frames. This driver provides support for
resizing and format conversion from YUYV to YUV420.

This operation is of the utmost importance since some of these
SoCs like i.MX27 include an H.264 video codec which only
accepts YUV420 as input.


[PATCH v3 1/2] MX2: Add platform definitions for eMMa-PrP device.
[PATCH v3 2/2] MEM2MEM: Add support for eMMa-PrP mem2mem operations.
