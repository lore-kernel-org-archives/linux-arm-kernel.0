From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 13 Sep 2012 21:24:43 +0530
Subject: [PATCH 0/2] lis3: lis3lv02d_i2c: Add device tree support
Message-ID: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First patch adds device tree support to lis3lv02d_i2c driver and
second patch adds platform data for lis331dlh driver to am335x
EVM. These patches were tested on AM335x-EVM.

AnilKumar Ch (2):
  lis3: lis3lv02d_i2c: Add device tree support
  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm

 arch/arm/boot/dts/am335x-evm.dts       |   42 ++++++++++++++++++++++++++++++++
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |   13 ++++++++++
 2 files changed, 55 insertions(+)

-- 
1.7.9.5
