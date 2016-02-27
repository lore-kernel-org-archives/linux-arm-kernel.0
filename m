From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 27 Feb 2016 17:58:57 +0100
Subject: [PATCH v4 0/2] ?hci-platform: Add support for controllers with more
 then one reset line
Message-ID: <1456592339-31767-1-git-send-email-hdegoede@redhat.com>
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

Changes in v4:
-Fix Ugly continuation line
-Add Acked-by: Alan Stern <stern@rowland.harvard.edu>

Regards,

Hans
-
