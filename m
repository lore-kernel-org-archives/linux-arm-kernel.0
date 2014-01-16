From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 16 Jan 2014 09:15:21 +0100
Subject: [PATCHv2 0/2] ARM: dts: imx53: add support for Ka-Ro TX53 modules
Message-ID: <1389860123-14874-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Ka-Ro electronics GmbH TX53 modules.
There are two distinct module types. One with an LVDS display
interface and SATA support, the other with a parallel LCD
interface and no SATA interface.

Changes wrt. v1:
- set the '#pwm-cells' property locally due to the changed
  pwm-polarity patch that made this property optional.
  see <1389859585-14006-3-git-send-email-LW@KARO-electronics.de>
