From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Jun 2015 21:41:40 +0200
Subject: [PATCH 0/3] mfd: ax20x: Add axp152 support
Message-ID: <1435088503-20776-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee, Maxime,

Here is a small patch-series adding mfd support for the AXP152, this
gives us power-off and power-button capabilities on the AXP152 as those
parts are compatible with the AXP20x PMIC-s.

Lee, if you can review and merge the actual mfd patch, then Maxime can pick
up the dts patches once the mfd bits are merged.

Regards,

Hans
