From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sat, 20 Feb 2010 16:32:01 +0100
Subject: [PATCH  0/3] MXC PCMCIA Support 
Message-ID: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the MXC PCMCIA / CF controller.

It has been tested on MX21 (with CF card + ide-cs as well as a
broadcom based wificard using b43 driver)

It has been compile only tested for MX27, MX31 as I don't have
this hardware but the code is based on Freescale's MX31.

Changes since RFC:
   * Split arch specifc changes from driver
   * Update to 2.6.33-rc8 [soc-common is now a standalone module]
  
