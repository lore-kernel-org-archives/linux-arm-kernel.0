From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Apr 2015 15:27:21 -0700
Subject: [PATCH 0/3] BCM2835 core mailbox support
Message-ID: <1430173644-19099-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following srwarren's suggestion, I've re-split the mailbox driver I
had previously submitted so that it only exposes a single channel and
leaves the previous "channel" notion up to a firmware-specific device
driver.

I'll be submitting the firmware-specific driver in a separate mail
thread -- hopefully this code is ready now, while I expect to get
feeback on the other driver.

This code can also be found at https://github.com/anholt/linux/tree/rpi-mbox-only
