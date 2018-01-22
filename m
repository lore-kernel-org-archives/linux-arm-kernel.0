From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 22 Jan 2018 17:12:06 -0600
Subject: [GIT PULL v2] updates to soc/fsl drivers for v4.16
Message-ID: <1516662726-12584-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainer,

Please merge the following tag to get updates to the soc/fsl/guts driver
for support of additional SoCs and more error path handling.

v2: I have restored the baseline of the pull request to 4.15-rc2.  The two
patches are pretty simple and straightforward.  Please reconsider to merge it.

Thanks,
Leo


The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.16

for you to fetch changes up to 14b055f43915a81be46d7e98f6f237bee62c6b0c:

  soc: fsl: guts: Add a NULL check for devm_kasprintf() (2018-01-22 16:59:48 -0600)

----------------------------------------------------------------
FSL/NXP SoC drivers updates for 4.16

This adds new SoC support and more error path handling to the guts
driver.

----------------------------------------------------------------
Fabio Estevam (1):
      soc: fsl: guts: Add a NULL check for devm_kasprintf()

yangbo lu (1):
      soc: fsl: support GUTS driver for ls1012a/ls1046a

 drivers/soc/fsl/guts.c | 8 ++++++++
 1 file changed, 8 insertions(+)
