From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 17:38:22 +0000
Subject: SAM5D3 Xplained MMC device tree updates
Message-ID: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A small set to fix warnings from the kernel.

Note, the atmel_defconfig will require CONFIG_REGULATOR_GPIO
to be set.
