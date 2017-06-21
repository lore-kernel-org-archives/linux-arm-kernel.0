From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 21 Jun 2017 10:35:52 -0500
Subject: [GIT PULL 2/2] SoCFPGA update for v4.13
In-Reply-To: <1498059352-9483-1-git-send-email-dinguyen@kernel.org>
References: <1498059352-9483-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1498059352-9483-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this SoCFPGA Kconfig update for v4.13.

Thanks,
Dinh


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.13

for you to fetch changes up to 139358be24e526bc8d050e319cdd4e2d1941503e:

  ARM: socfpga: Increase max number of GPIOs (2017-06-21 10:16:02 -0500)

----------------------------------------------------------------
SoCFPGA updates for v4.13
- Increase number of available GPIOs in Kconfig

----------------------------------------------------------------
Marek Vasut (1):
      ARM: socfpga: Increase max number of GPIOs

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)
