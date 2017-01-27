From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 27 Jan 2017 16:44:07 -0500
Subject: [PATCH 0/2] PCI: iproc: MPS fix and quirks
Message-ID: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A patch that corrects an issue where the MPS could not be set, and
another that fixes some quirks in the PAXC

Jon Mason (2):
  PCI: iproc: allow the MPS to be set
  PCI: Add quirk entry for NS2 PAXC PCI

 drivers/pci/host/pcie-iproc.c |  5 ++++-
 drivers/pci/quirks.c          | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.7.4
