From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu, 26 Nov 2009 15:47:59 +0900
Subject: Patches for S3C64XX SPI controller driver
Message-ID: <1259218079-9755-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

 In subsequent mails, I am going to submit new SPI driver
for the S3C64xx Samsung SoCs.

 The driver has been tested with 9pin MMC card slot soldered
to pins of SPI-1 port on the SMDK6410.
Since that is not a standard h/w configuration of SMDK, the patch
to enable SPI-1 controller for MMC_SPI in machine init code,
is not being submitted.

Regards.
