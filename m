From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 14:42:07 +0200
Subject: [PATCH v5 0/3] musb: sunxi: Add support for the Allwinner sunxi musb
Message-ID: <1434199330-22263-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

Here is a patch series with all my oustanding musb-sunxi changes pending
for merging into 4.3.

This includes the 5th iteration of the patch for adding the basic sunxi-glue,
the major change in v5 is that it has been ported to the extcon API changes
which are queued up for 4.2 from :

http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-ne

which already merged in GKH's char-misc branch for 4.2, this means that
this series now depends on those changes.

Besides that I've also squashed in a fix I send out recently which removes
the need for the special MUSB_SUN4I flag + core changes checking for that
flag which my original version has. Meaning that the changes are nowly
soley confined to the addition of drivers/usb/musb/sunxi.c + matching
Kconfig / Makefile changes.

Other than that this is a resend of some of the other feature addition
patches I recently send rebased on top of v5 of the musb sunxi glue.

Please merge this series for 4.3.

Regards,

Hans
