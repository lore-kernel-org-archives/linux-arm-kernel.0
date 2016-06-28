From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 28 Jun 2016 13:55:03 +0200
Subject: [PATCH v3 0/2] [for arm-soc] mach-tango updates for v4.8
Message-ID: <57726597.8030501@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello arm-soc maintainers,

Could you please merge the following patches?

(Ideally, the MAINTAINERS update would be merged as a fix into
the next 4.7 release candidate.)

Marc Gonzalez (2):
  ARM: tango: add HOTPLUG_CPU support
  Update ARM/TANGO section

 MAINTAINERS                   |  3 +--
 arch/arm/mach-tango/platsmp.c | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-tango/smc.h     |  4 +++-
 3 files changed, 34 insertions(+), 3 deletions(-)

Regards.
