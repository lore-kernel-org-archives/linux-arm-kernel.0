From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jun 2016 21:02:50 +0200
Subject: [PATCH v4 0/4] usb: musb: sunxi: Fixes + peripheral-only mode
Message-ID: <1465585374-10213-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v4 of my patch-set with a couple of fixed and peripheral-only
mode for the sunxi musb / otg-phy code.

The first patch changes a generic usb helper function, the next 2 patches
are phy patches and the last patch is a musb patch.

And all 4 patches depend on eachother. As such I believe it would be
best for these 4 patches to be merged directly in Greg's usb tree.

Kishon, Bin Liu, do you agree it would be best for Greg to merge these
4 directly ? This should not lead to any merge problems, the first patch
is a common usb code patch and such belongs in Greg's tree, the other 3
only touch sunxi files.

Kishon if you agree it is bes to have all 4 merged via Greg's usb tree,
can we have your Acked-by for the 2 phy patches ?

Regards,

Hans
