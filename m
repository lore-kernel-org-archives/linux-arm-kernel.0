From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Jan 2015 11:35:53 +0000
Subject: [PATCH RFC 0/2] ARM: DT: add bindings for system suspend
Message-ID: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There are various attempts on the list to implement system suspend
on ARM64 using CPU Idle. Here is an attempt to standardise it by 
defining DT bindings for the same and hence provide a generic solution
without associating it with CPUIdle.

Currently only PSCI is supported as entry method in this series.

Regards,
Sudeep

P.S: I am on vacation till Jan 31st and will have limited access to
emails, so there might be delays in my response.

Sudeep Holla (2):
  Documentation: arm: define DT bindings for system suspend
  ARM64: psci: implement system suspend using PSCI v0.2 CPU SUSPEND

 Documentation/devicetree/bindings/arm/psci.txt     | 11 +++
 .../devicetree/bindings/arm/system-suspend.txt     | 93 ++++++++++++++++++++++
 arch/arm64/kernel/psci.c                           | 83 ++++++++++++++++---
 3 files changed, 178 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/system-suspend.txt

-- 
1.9.1
