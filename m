From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:42:53 +0200
Subject: [PATCH 00/14] Convert ehci-mv to DT
Message-ID: <20180822204307.13251-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set makes it possible to use the Marvell EHCI driver with
DT-based machines.

Tested on a marvell,mmp2-based OLPC XO 1.75 laptop. (With a custom
appended DT that will be submitted in a separate patch set. The
machine's OpenFirmware provides a device tree, but that one is too
buggy to boot a pure marvell,mmp2 FDT kernel.)

Lubo
