From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Oct 2014 10:24:46 +0200
Subject: [PATCH v2 0/4] input: Add new sun4i-lradc-keys driver
Message-ID: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

After a bit of a pause due to -ENOTIME, here is my 2nd attempt at getting
support for the lradc attached tablet keys found one some Allwinner boards
upstream.

I've dubbed this v2 even though there has been more then one version before
because I've lost count, and as said this represents the 2nd attempt at getting
this upstream.

The major change from the previous attempt is that now the devicetree
description has one subnode per key just like gpio-keys has.

I hope this version is to everyones liking and can be merged soon :) The intend
is for the actual driver to go upstream through Dmitry's tree, where as the
3 dts patches should go upstream through Maxime's tree.

Thanks & Regards,

Hans
