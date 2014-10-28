From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 21:55:48 +0100
Subject: [PATCH v3 0/2] dmaengine: Add driver documentation
Message-ID: <1414529750-14431-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the third attempt at documenting how to write a dmaengine
driver.

Changes from v2:
  - English corrections from Randy Dunlap
  - Reworked the burst explanations
  - Reworked the interleaved transfers explanations

Maxime Ripard (2):
  Documentation: dmaengine: Move the current doc to a folder of its own
  Documentation: dmaengine: Add a documentation for the dma controller
    API

 .../{dmaengine.txt => dmaengine/client.txt}        |   0
 Documentation/dmaengine/provider.txt               | 366 +++++++++++++++++++++
 2 files changed, 366 insertions(+)
 rename Documentation/{dmaengine.txt => dmaengine/client.txt} (100%)
 create mode 100644 Documentation/dmaengine/provider.txt

-- 
2.1.1
