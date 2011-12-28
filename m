From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 22:19:28 -0800
Subject: [PATCH v2 0/2] Input: tegra-kbc - configure through device tree
Message-ID: <1325053170-6984-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches add device-tree bindings and probing to tegra-kbc,
and they also provide a simplified way of specifying the, to date, only known
non-default keymap.

Fixes since v1: added debounce/repeat delay properties, setup of pin_cfg
and verified that it works as expected on seaboard. Actual device tree
update will be posted separately for inclusion through tegra tree.


-Olof
