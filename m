From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 10:09:32 +0100
Subject: [GIT PULL] Allwinner DRM changes for 4.11
Message-ID: <20170131090932.rvrpfrkjlspoxhbd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Please pull the following patch for the next merge window.

Thanks!
Maxime

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-drm-for-4.11

for you to fetch changes up to 0f0861e31e3c59ca4bc1ec59d99260cfca79740e:

  drm/sun4i: Fix a return value in case of error (2017-01-02 22:27:58 +0100)

----------------------------------------------------------------
Allwinner DRM changes for 4.11

Just one minor fix.

----------------------------------------------------------------
Christophe JAILLET (1):
      drm/sun4i: Fix a return value in case of error

 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/f28cfad0/attachment.sig>
