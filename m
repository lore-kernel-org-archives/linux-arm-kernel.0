From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Fri, 16 Oct 2015 09:28:43 -0500
Subject: [GIT PULL] SoCFPGA DTS cleanup for v4.4
In-Reply-To: <1445005724-32349-1-git-send-email-dinh.linux@gmail.com>
References: <1445005724-32349-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <1445005724-32349-2-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling this patch for v4.4.

Thanks,
Dinh

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_for_v4.4_cleanup

for you to fetch changes up to 0cdbec626e2e936a7db43d6a697e70673d4478bf:

  ARM: socfpga: dts: sort nodes alphabetically (2015-10-16 08:39:22 -0500)

----------------------------------------------------------------
SoCFPGA dts cleanup for v4.4
- Re-order DTS nodes into correct alphabetical order

----------------------------------------------------------------
Steffen Trumtrar (1):
      ARM: socfpga: dts: sort nodes alphabetically

 arch/arm/boot/dts/socfpga.dtsi | 128 ++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 64 deletions(-)
