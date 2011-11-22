From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 22 Nov 2011 13:01:54 +0100
Subject: Add support form eMMa-PrP in i.MX2 chips as a mem2mem device.
Message-ID: <1321963316-9058-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


i.MX2x SoCs have a PrP which is capable of resizing and format
conversion of video frames. This driver provides support for
resizing and format conversion from YUYV to YUV420.

This operation is of the utmost importance since some of these
SoCs like i.MX27 include an H.264 video codec which only
accepts YUV420 as input.

Changes since v1:
- Split patch in a series of two.
- Some fixes to mem2mem driver file.
