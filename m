From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  2 Jun 2016 17:14:04 +0200
Subject: [PATCH v5 resend 0/2] ?hci-platform: Add support for controllers with
 more then one reset line
Message-ID: <1464880446-5919-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a resend of my last version of the patch set to support usb
controllers which have multiple resets.

The shared reset controller support this depends on has landed in 4.7-rc1,
so this patch-set should be ready for merging now.

Changes in v2:
-Switch to now shared reset_[de]assert functions

Changes in v3:
-Adjust for changes to shared-reset reset-controller functions

Changes in v4:
-Fix Ugly continuation line
-Add Acked-by: Alan Stern <stern <at> xxxxxxxxxxxxxxxxxxx>

Changes in v5:
-No changes, resend for merging into 4.7

Thanks & Regards,

Hans
