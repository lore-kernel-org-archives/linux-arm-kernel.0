From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 10 Jun 2014 17:24:37 +0200
Subject: [PATCH] Marvell releases a public Armada 370 datasheet
Message-ID: <1402413878-20224-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Marvell has very recently (last week) released a public version of the
datasheet for the Marvell Armada 370 SoC. This is a very good news for
all the developers and contributors interested by the Armada 370.

The following patch adds the reference to this specification in the
appropriate kernel documentation, where we already reference the
publicly available documentation for other Marvell SoCs.

The documentation for the Armada XP (another, more powerful SoC,
released approximately at the same time as the Armada 370) is not yet
publicly available, but hopefully it should also be released in the
near future as well.

Best regards,

Thomas

Thomas Petazzoni (1):
  Documentation: arm: add URLs to public datasheets for the Marvell
    Armada 370 SoC

 Documentation/arm/Marvell/README | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.0.0
