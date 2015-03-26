From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 26 Mar 2015 15:53:40 +0100
Subject: [PATCH v2 0/5] ARM: sunxi: SRAM mapping support
Message-ID: <1427381625-6942-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my cleaned up version of Maxime's sunxi SRAM controller driver.

Changes since v1:
- Make the SUNXI_SRAM Kconfig option hidden, enabled by default if ARCH_SUNXI
- Fix some typos in the comments in the dts file, both in the example in the
  devicetree-binding documentation, as well as in the actual dts files
- Drop the bogus change to drivers/net/ethernet/stmicro/stmmac/Kconfig

Since this is a prereq for my musb work, if there are no objections then I
would like to see this go upstream soon.

Since it only touches sunxi files (and one Makefile), it is probably best if
this all goes upstream through Maxime.

Regards,

Hans
