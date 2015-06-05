From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 20:53:34 +0200
Subject: [PATCH 0/7] musb-sunxi / phy-sun4i-usb: Add suppor for new SoCs
Message-ID: <1433530421-12197-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe and Kishon,

This musb-sunxi / phy-sun4i-usb series adds supports for the otg and
host usb-phys found on newer sunxi SoCs and for the musb ip found on
newer sunxi SoCs. This series sits on top of the 2 still outstanding 
musb-sunxi / phy-sun4i-usb patches.

These patches (and the 2 still outstanding patches) have no compile
time dependecies on each other. So they can be merged through your 
trees seperately, or they can all go through one tree, depending   
on what you prefer.

Regards,

Hans
