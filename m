From: p.osciak@samsung.com (Pawel Osciak)
Date: Wed, 23 Dec 2009 11:08:50 +0100
Subject: [PATCH 0/2] [ARM] Add Samsung S3C/S5P image rotator driver
Message-ID: <1261562933-26987-1-git-send-email-p.osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is a driver for Samsung S3C/S5P series image rotator device driver.
This driver utilizes the proposed memory-to-memory V4L2 framework, just posted
by me in the previous patch series.

An example application for testing the device is also included.


This series contains:

[PATCH 1/2] [ARM] samsung-rotator: Add rotator device platform definitions.
[PATCH 2/2] [ARM] samsung-rotator: Add Samsung S3C/S5P rotator driver
[EXAMPLE] S3C/S5P image rotator test application


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
