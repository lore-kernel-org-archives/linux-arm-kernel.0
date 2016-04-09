From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  9 Apr 2016 16:15:13 +0200
Subject: [PATCH v5 0/2] ?hci-platform: Add support for controllers with more
 then one reset line
Message-ID: <1460211315-17915-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, et al,

Here is a resend of my last version of the patch set to support usb
controllers which have multiple resets.

Unfortunately the shared reset controller support this depends on did
not make it into 4.6. Philipp Zabel, the reset maintainer (in the Cc)
has put these patches in a stable branch / tag here:

git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.7

Can you please merge in this tag and then these 2 patches for 4.7 ?

Changes in v2:
-Switch to now shared reset_[de]assert functions

Changes in v3:
-Adjust for changes to shared-reset reset-controller functions

Changes in v4:
-Fix Ugly continuation line
-Add Acked-by: Alan Stern <stern@xxxxxxxxxxxxxxxxxxx>

Changes in v5:
-No changes, resend for merging into 4.7

Thanks & Regards,

Hans
