From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue,  2 Jun 2015 21:14:00 -0500
Subject: [PATCH 0/2] ARM: socfpga: Add CPU_METHOD_OF_DECLARE for SoCFPGA
Message-ID: <1433297642-3818-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinh.linux@gmail.com>

Hi Arnd, Kevin, Olof:

Please apply these 2 patches for v4.2. I could not do a pull request for
these as they will cause a merge conflict for arm-soc/next.

Thanks,

Dinh Nguyen (2):
  ARM: socfpga: use CPU_METHOD_OF_DECLARE for socfpga_cyclone5
  ARM: socfpga: add CPU_METHOD_OF_DECLARE for Arria 10

 arch/arm/mach-socfpga/core.h    |  3 ++-
 arch/arm/mach-socfpga/platsmp.c | 36 +++++++++++++++++++++++++++++++++++-
 arch/arm/mach-socfpga/socfpga.c |  1 -
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
1.9.1.315.g3f09db0
