From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 16:27:08 +0100
Subject: [PATCH v2 0/2] ARM: dts: sun7i: Add OOB irq support to boards with
 sdio wifi
Message-ID: <1426001230-15906-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here is v2 of the dts patches to add OOB irq support to boards with sdio
wifi.

Changes since v1:
-New patch to set the address / size cells in the dtsi
-Use macro for the irq type

Regards,

Hans
