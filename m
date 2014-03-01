From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:19 +0100
Subject: [PATCH 00/19] ARM: sunxi: dt: ahci, ehci and ohci support
Message-ID: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

With all USB and AHCI bits going upstream for 3.15, here are the matching
dts bits for AHCI and USB host support.

As an added bonus I've also thrown in 2 new boards (already with ahci and
usb support).

Please let me know if these need any fixups, and if not please add them
to your dt-for-3.15 branch. Note they are based on top of that branch so
they should apply cleanly.

Regards,

Hans
