From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 25 Feb 2015 15:54:10 -0700
Subject: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
Message-ID: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches used to be part of my cpuidle patchset, think these can go in
independently.

The patches do the following -

1. Add QCOM Secure Monitor specific enumeration for warm boot on qcom targets
2. Add an API to set up the warmboot address. Consolidate the warm boot flags
into the implementation file 

Thanks,
Lina

Lina Iyer (2):
  ARM: qcom: Add SCM warmboot flags for quad core targets.
  qcom: scm: Add scm_set_warm_boot_addr function

 arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-qcom/scm-boot.h |  5 +++--
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.1.0
