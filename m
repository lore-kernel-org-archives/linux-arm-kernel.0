From: leoyang.li@nxp.com (Li Yang)
Date: Wed, 10 Jan 2018 17:56:36 -0600
Subject: [GIT PULL] updates to soc/fsl drivers for v4.16
Message-ID: <1515628596-4715-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainer,

Please merge the following tag to get updates to the soc/fsl/guts driver
for support of additional SoCs and more error path handling.

Thanks,
Leo


The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:

  Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.16

for you to fetch changes up to 00ce0a2304014c73c2b7915215c7b3c73e2a25aa:

  soc: fsl: guts: Add a NULL check for devm_kasprintf() (2018-01-10 16:54:26 -0600)

----------------------------------------------------------------
FSL/NXP SoC drivers updates for 4.16

This adds new SoC support and more error path handling to the guts
driver.

----------------------------------------------------------------
Fabio Estevam (1):
      soc: fsl: guts: Add a NULL check for devm_kasprintf()

yangbo lu (1):
      soc: fsl: guts: add support for ls1012a and ls1046a

 drivers/soc/fsl/guts.c | 8 ++++++++
 1 file changed, 8 insertions(+)
