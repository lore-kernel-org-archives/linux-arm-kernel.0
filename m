From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 14:37:44 +0200
Subject: [PATCH v5 0/7] phy-sun4i-usb: Add OTG and newer SoC support
Message-ID: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Here is a patch series with all my oustanding phy-sun4i-usb changes pending
for merging into 4.3.

This includes the 5th iteration of the OTG support addition, now with the
extcon provider support addition split-out into a new patch and ported to
the extcon API changes which are queued up for 4.2 from :

http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next-v4.2

which already merged in GKH's char-misc branch for 4.2, this means that
this series now depends on those changes.

Other than that this is a resend of some of the other feature addition
patches I recently send rebased on top of v5 of the OTG support.

Please merge this series for 4.3.

Regards,

Hans
