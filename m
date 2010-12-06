From: horms@verge.net.au (Simon Horman)
Date: Mon, 06 Dec 2010 09:12:43 +0900
Subject: [patch 0/3] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
Message-ID: <20101206001243.949375995@vergenet.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series allows a ROM-able zImage to be written to MMC and for
SuperH Mobile ARM to boot directly from the MMCIF hardware block.

The first two patches make minor preparatory changes to the MMCIF code.
The last patch contains the code to load from the MMCIF hardware block.
