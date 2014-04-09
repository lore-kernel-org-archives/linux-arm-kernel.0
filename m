From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  9 Apr 2014 09:27:27 +0200
Subject: [RESEND: PATCH 0/2] TC3589x keypad device tree support
Message-ID: <1397028447-15347-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RESEND: can we merge this to the MFD+input trees now?

It seems no subsystem maintainers have any opinions and the DT
bindings people are silent on the matter since weeks.

Linus Walleij (2):
  mfd: tc3589x: Add device tree bindings
  input: tc3589x-keypad: support probing from device tree

 Documentation/devicetree/bindings/mfd/tc3589x.txt | 107 ++++++++++++++++++++++
 drivers/input/keyboard/tc3589x-keypad.c           |  66 ++++++++++++-
 2 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/tc3589x.txt

-- 
1.9.0
