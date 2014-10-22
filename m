From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Oct 2014 13:11:01 +0200
Subject: [PATCH v3 0/4] input: Add new sun4i-lradc-keys driver
Message-ID: <1413976265-12805-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v3 of my patchset for the lradc attached tablet keys found one some
Allwinner boards.

Changes since v2:
-s/KEY_HOME/KEY_HOMEPAGE/
-s/sun4i-lradc-keys/sun4i-a10-lradc-keys/
-Use mV as address for the key subnodes in devicetree
-dts formatting fixes according to Maxime's review
-Do not set .owner field, as module_platform_driver already does that

Changes since previous postings a long time ago:
-device tree description now has one subnode per key just like gpio-keys

I hope this version is to everyones liking and can be merged soon :) The intend
is for the actual driver to go upstream through Dmitry's tree, where as the
3 dts patches should go upstream through Maxime's tree.

Thanks & Regards,

Hans
