From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 23 Sep 2018 17:24:50 +0200 (CEST)
Subject: [PATCH v3 1/4] staging/vc04_services: Use correct cache line size
In-Reply-To: <1537172544-104852-2-git-send-email-phil@raspberrypi.org>
References: <1537172544-104852-1-git-send-email-phil@raspberrypi.org>
 <1537172544-104852-2-git-send-email-phil@raspberrypi.org>
Message-ID: <1660239654.224490.1537716290663@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Phil Elwell <phil@raspberrypi.org> hat am 17. September 2018 um 10:22 geschrieben:
> 
> 
> Use the compatible string in the DTB to select the correct cache line
> size for the SoC - 32 for BCM2835, and 64 for BCM2836 and BCM2837.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
