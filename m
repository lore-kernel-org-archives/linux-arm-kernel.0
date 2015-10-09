From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Oct 2015 14:27:41 -0700
Subject: bcm2835 (Raspberry Pi) KMS driver
Message-ID: <1444426068-15817-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of the Raspberry Pi KMS series.  Now that we've got a
real clock driver, I can actually set new video modes.  Also in this
version, most of the custom DT stuff from before is gone, thanks to
finding exynos's platform_driver component matching code (I have sent
separate patches to drivers/base to make helpers for doing it).

https://github.com/anholt/linux/tree/vc4-kms-squash-2
