From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Dec 2013 14:27:56 +0100
Subject: [PATCH 0/4] add support for Ka-Ro TX6 modules
Message-ID: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

resent with [PATCH 0/4] added in the subject...


This patchset adds support for the Ka-Ro electronics TX6 modules.
There are four distinct module types with i.MX6Q or i.MX6DL and LVDS
or LCD interface.

The patchset also adds some new pingroups to the imx6qdl pingroup
include file that are used by the TX6 dts files.

The first patch adds aliases for the CAN nodes that are used by U-Boot
to modify the DTB according to environment settings.
