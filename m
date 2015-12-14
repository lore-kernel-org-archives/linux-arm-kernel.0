From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Dec 2015 13:06:07 +0100
Subject: [GIT PULL] Allwinner fixes for 4.4
Message-ID: <20151214120607.GA21693@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here a couple of fixes for the 4.4 merge window.

Thanks!
Maxime

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.4

for you to fetch changes up to 43675ffafd3c3373f82691f539df3dc7403877fe:

  bus: sunxi-rsb: unlock on error in sunxi_rsb_read() (2015-11-17 09:40:49 +0100)

----------------------------------------------------------------
Allwinner fixes for 4.4

Two patches, one to fix the touchscreen axis on one Allwinner board, and
the other one fixing a mutex unlocking issue on one error path in the RSB
driver.

----------------------------------------------------------------
Dan Carpenter (1):
      bus: sunxi-rsb: unlock on error in sunxi_rsb_read()

Karsten Merker (1):
      ARM: dts: sunxi: sun6i-a31s-primo81.dts: add touchscreen axis swapping property

 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 1 +
 drivers/bus/sunxi-rsb.c                  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/0dcc9a15/attachment.sig>
