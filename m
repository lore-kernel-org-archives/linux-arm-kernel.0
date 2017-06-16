From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 15 Jun 2017 23:39:11 -0700
Subject: [PATCH RESEND 0/2] Add support for ARM CCN-502 interconnect
Message-ID: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for ARM CCN-502 interconnect.
CCN-502 interconnect is already compatible with the 
existing ARM CCN driver, which supports CCN-504.

Velibor Markovski (2):
  dt-bindings: arm-ccn: Add bindings info for CCN-502 compatible string
  bus: arm-ccn: Enable stats for CCN-502 interconnect

 Documentation/devicetree/bindings/arm/ccn.txt | 1 +
 drivers/bus/arm-ccn.c                         | 1 +
 2 files changed, 2 insertions(+)

-- 
2.5.0
