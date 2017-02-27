From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Mon, 27 Feb 2017 14:30:24 +0200
Subject: [PATCH v1 0/2] Misc fixes for ARM page table allocator (long/short
 descriptor format)
Message-ID: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

There is a small patch series which contains the same fix for both
descriptor formats based on the preceding RFC patches:
https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020477.html

Oleksandr Tyshchenko (2):
  iommu/io-pgtable-arm: Check for leaf entry before dereferencing it
  iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it

 drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
 drivers/iommu/io-pgtable-arm.c     | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.7.4
