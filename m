From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 13:03:50 +0100
Subject: [PATCH 0/8] S3C64xx fixes
Message-ID: <b2e8f9f70911200403k38acc43cu68520db26d0a2148@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on getting the SmartQ7 supported in mainline (which isn't ready for
submission yet), but I've got a few S3C64xx patches which it depends on that I'm
submitting for inclusion.

Most of these have been posted before, but didn't get much/any response.

[PATCH 1/8] s3c6410: Add new quirk in sdhci driver and update ADMA
descriptor build.
[PATCH 2/8] s3c6410: Enable ADMA feature in 6410 sdhci controller.
[PATCH 3/8] S3C64xx: remove SDHCI_QUIRK_NO_MULTIBLOCK
[PATCH 4/8] S3C64xx: add HSMMC2 support
[PATCH 5/8] S3C64xx: fix USB OTG compilation
[PATCH 6/8] S3C: merge ADC drivers and add support for the S3C64xx
[PATCH 7/8] S3C64xx: add support for all group 0 external interrupts
[PATCH 8/8] S3C64xx: add support to the RTC driver


Thanks,
Maurus Cuelenaere
