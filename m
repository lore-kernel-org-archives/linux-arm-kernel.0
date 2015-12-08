From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue,  8 Dec 2015 16:33:02 -0600
Subject: [GIT PULL] SoCFPGA defconfig for v4.5
In-Reply-To: <1449613982-25888-1-git-send-email-dinh.linux@gmail.com>
References: <1449613982-25888-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <1449613982-25888-2-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling this defconfig update for v4.5.

Thanks,
Dinh

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_defconfig_for_v4.5

for you to fetch changes up to 93699220ecace65e5385511f9f7119fd49837adb:

  arm: socfpga_defconfig: enable USB dual-role and cleanup (2015-12-03 16:17:55 -0600)

----------------------------------------------------------------
SoCFPGA defconfig update for v4.5
-Enable USB OTG dual-role and some cleanup by make savedefconfig

----------------------------------------------------------------
Dinh Nguyen (1):
      arm: socfpga_defconfig: enable USB dual-role and cleanup

 arch/arm/configs/socfpga_defconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
