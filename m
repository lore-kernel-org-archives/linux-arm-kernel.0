From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 27 Dec 2016 00:25:12 +0800
Subject: [PATCH 0/6] Allwinner H5 and Xunlong Orange Pi PC 2 support
Message-ID: <20161226162518.5367-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset imports two necessary patches for Allwinner H5: CCU driver and
the pinctrl driver, both are based on the H3 ones.

Some patches of H5 dtsi file are directly taken from Andre Przywara's kernel
tree, but did more cleanup.

The Orange Pi PC 2 dtsi file is also taken there.
