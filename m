From: velibor.markovski@broadcom.com (Velibor Markovski)
Date: Fri, 10 Feb 2017 12:35:07 -0800
Subject: [PATCH INTERNAL 0/2] Add support for ARM CCN-502 interconnect
Message-ID: <1486758909-23662-1-git-send-email-velibor.markovski@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for ARM CCN-502 interconnect.
CCN-502 interconnect is already compatible with the 
existing ARM CCN driver, which supports CCN-504.

This patchset is based on v4.10-rc3 and is available from github:
repo: https://github.com/Broadcom/arm64-linux
branch: arm64-ccn502

Velibor Markovski (2):
  dt-bindings: arm-ccn: Add bindings info for CCN-502 compatible string
  bus: arm-ccn: Enable stats for CCN-502 interconnect

 Documentation/devicetree/bindings/arm/ccn.txt | 1 +
 drivers/bus/arm-ccn.c                         | 1 +
 2 files changed, 2 insertions(+)

-- 
1.9.1
