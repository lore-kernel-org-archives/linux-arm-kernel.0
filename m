From: ray.jui@broadcom.com (Ray Jui)
Date: Fri,  1 Jun 2018 17:56:05 -0700
Subject: [PATCH v3 0/3] Update Broadcom Stingray clock entries
Message-ID: <1527900968-12017-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series updates Broadcom Stingray clock entries so they match the
latest ASIC datasheet

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-clk-v3

Changes since v2:
 - Move dt-binding header change to the same patch with the binding doc
update

Changes since v1:
 - Fix patch author to Pramod Kumar on all 3 patches
 - Fix patch subject spelling error on patch 2/3

Pramod Kumar (3):
  dt-bindings: clk: Update Stingray binding doc
  clk: bcm: Update and add Stingray clock entries
  arm64: dts: Update Stingray clock DT nodes

 .../bindings/clock/brcm,iproc-clocks.txt           |  26 ++--
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi |  26 ++--
 drivers/clk/bcm/clk-sr.c                           | 135 ++++++++++++++++++---
 include/dt-bindings/clock/bcm-sr.h                 |  24 ++--
 4 files changed, 170 insertions(+), 41 deletions(-)

-- 
2.1.4
