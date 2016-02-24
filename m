From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 24 Feb 2016 12:15:15 +0100
Subject: [PATCH v3 0/2] ?hci-platform: Add support for controllers with more
 then one reset line
Message-ID: <1456312517-24211-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a new version of my patch-set to support usb controllers which
have multiple resets. These patches apply on top of the related
reset-controller patches which have just been merged here:

git://git.pengutronix.de/git/pza/linux.git reset/next

Changes in v2:
-Switch to now shared reset_[de]assert functions

Changes in v3:
-Adjust for changes to shared-reset reset-controller functions

Regards,

Hans
