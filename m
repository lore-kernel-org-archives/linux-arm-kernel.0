From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  7 Sep 2010 18:09:01 +0300
Subject: [PATCH 0/2] s3c24xx: fix s3cmci DMA support 
Message-ID: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes DMA support for s3c24xx SoCs, now it's
possible to use DMA with s3cmci driver. It was tested on
rx1950 (s3c2442), h1940 (s3c2410) and freerunner (s3c2442),
unfortunately s3cmci doesn't work with SDIO cards when DMA
is enabled, but at least patch breaks nothing - sound works
OK on freerunner, and it's still possible to use PIO.
