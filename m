From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:01:39 +0200
Subject: [PATCH 0/3] phy-sun4i-usb: 3 misc. fixes
Message-ID: <1438329702-10365-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Here are 3 small patches for the phy-sun4i-usb code.

The first patch is a small bugfix for building the sun4i musb code as
module which seems to have fallen through the cracks.

The second patch is a preparation patch for the third patch which
fixes the case of boards with a working VBus regulator, but broken
VBus detection support, yes unfortunately such boards exist.

Can you please merge these 3 into linux-phy/next ?

Thanks & Regards,

Hans
