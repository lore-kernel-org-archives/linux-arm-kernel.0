From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 25 Oct 2016 08:26:35 -0700
Subject: [PATCH 0/4] PM / Domains: DT bindings for domain idle states and doc
 updates
Message-ID: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

This patchset adds the following on top of the patches [0-7] of v3[1], that you
have already queued up for linux-next.

- New DT compatible for PM Domain idle states.
- Update documentation for PM domain idle state
(Pls. note that this new compatible is yet to be approved by DT reviewers)
- Update device/domain documentation per your suggestion

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg536181.html

Lina Iyer (4):
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains
  dt-bindings: add domain-idle-state compatible to arm,idle-state
  dt-bindings: Update domain-idle-state binding to use correct
    compatibles
  PM / Domains: Use domain-idle-state compatible

 Documentation/devicetree/bindings/arm/idle-states.txt    |  3 +++
 Documentation/devicetree/bindings/power/power_domain.txt |  9 +++++----
 Documentation/power/devices.txt                          | 14 +++++++++++++-
 drivers/base/power/domain.c                              |  2 +-
 4 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.7.4
