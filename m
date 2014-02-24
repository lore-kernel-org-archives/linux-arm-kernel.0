From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 16:51:44 +0900
Subject: [PATCH 00/02] ARM: shmobile: Lager DT Reference USB PCI support
Message-ID: <20140224075144.20255.59443.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Lager DT Reference USB PCI support

[PATCH 01/02] ARM: shmobile: Lager DT USB PCI pinctrl setup via DTS
[PATCH 02/02] ARM: shmobile: Lager DT USB PCI platform devices

Enable USB1 and USB2 on the Lager board in case of Multiplatform
and DT reference board support. The devices are supported via a mix
of DTS (for pinctrl) and platform device (actual PCI device) when
DT bindings are not yet ready. This series allows us to move one
step closer towards being able to retire the Lager legacy code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc3-20140224
 on top of "[PATCH 00/12] ARM: shmobile: Rework include path for SoC files"
 and "[PATCH 00/03] ARM: shmobile: Break out and extend clock workaround"

 arch/arm/boot/dts/r8a7790-lager.dts            |   12 +++++-
 arch/arm/mach-shmobile/board-lager-reference.c |   46 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
