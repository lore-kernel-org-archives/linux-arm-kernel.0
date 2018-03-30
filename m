From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 30 Mar 2018 18:44:42 +0900
Subject: [PATCH 0/2] reset: uniphier: add support for PCIe and SATA
Message-ID: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add reset lines for PCI-express and SATA controllers implemented on
UniPhier SoCs.

Kunihiko Hayashi (2):
  reset: uniphier: add PCIe reset control support
  reset: uniphier: add SATA reset control support and change SATA-PHY ID

 drivers/reset/reset-uniphier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.7.4
