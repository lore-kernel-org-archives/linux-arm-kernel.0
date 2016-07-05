From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 21:55:37 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.7
Message-ID: <20160705195537.GA17805@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following fixes for the 4.7 cycle.

Thanks!
Maxime

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.7

for you to fetch changes up to 9ca91a65583c73e4be6e9f53323a7ae04e6803ef:

  clk: sunxi: remove unused variable (2016-06-16 09:18:29 +0200)

----------------------------------------------------------------
Allwinner clock fixes for 4.7

A bunch of changes for the display clocks merged in 4.7

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: sunxi: remove unused variable

Maxime Ripard (2):
      clk: sunxi: tcon-ch1: Do not return a negative error in get_parent
      clk: sunxi: display: Add per-clock flags

 drivers/clk/sunxi/clk-sun4i-display.c  | 5 ++++-
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/9b9588fd/attachment.sig>
