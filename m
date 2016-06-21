From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 21 Jun 2016 11:28:54 +0200
Subject: [PATCH v2 0/2] [for arm-soc] mach-tango updates
Message-ID: <576908D6.8090000@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello arm-soc maintainers,

Could you please merge the following patches?

o HOTPLUG support would be for 4.8
o Ideally, the MAINTAINERS update would be for the next 4.7 release candidate.

Marc Gonzalez (2):
  ARM: tango: add HOTPLUG_CPU support
  Update ARM/TANGO section

 MAINTAINERS                   |  3 +--
 arch/arm/mach-tango/platsmp.c | 17 +++++++++++++++++
 arch/arm/mach-tango/smc.h     |  4 +++-
 3 files changed, 21 insertions(+), 3 deletions(-)

Regards.
