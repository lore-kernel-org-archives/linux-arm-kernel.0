From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 23 Jan 2017 21:11:35 +0900
Subject: [PATCH/RFC 0/2] iommu/ipmmu-vmsa: IPMMU slave device whitelist
Message-ID: <148517349585.18128.10696161017872202809.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu/ipmmu-vmsa: IPMMU slave device whitelist

[PATCH/RFC 1/2] arm64: mm: Silently allow devices lacking IOMMU group
[PATCH/RFC 2/2] iommu/ipmmu-vmsa: Opt-in slave devices based on ES version

Here's a little prototype that shows how DT integration of IPMMU details
may be integrated and merged upstream based on SoC data sheet ahead of
time followed by enablement in the IPMMU driver code once the appropriate
SoC ES version has been released and the hardware has been tested.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of renesas-drivers-2017-01-10-v4.10-rc3

 arch/arm64/mm/dma-mapping.c |   10 +++++++++-
 drivers/iommu/ipmmu-vmsa.c  |   24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
