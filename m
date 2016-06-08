From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  8 Jun 2016 14:33:07 -0500
Subject: [GIT PULL] SoCFPGA DTS fix for v4.7
In-Reply-To: <1465414387-20171-1-git-send-email-dinguyen@kernel.org>
References: <1465414387-20171-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1465414387-20171-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this fix for v4.7.

Thanks,
Dinh

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_fix_for_v4.7

for you to fetch changes up to c106c21ce02e366f3dc887bff7c48f3f140c45c9:

  ARM: dts: socfpga: Add missing PHY phandle (2016-06-08 14:12:04 -0500)

----------------------------------------------------------------
SoCFPGA fix for v4.7
- Add missing PHY phandle for SoCFPGA VINING board

----------------------------------------------------------------
Marek Vasut (1):
      ARM: dts: socfpga: Add missing PHY phandle

 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 1 +
 1 file changed, 1 insertion(+)
