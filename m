From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 17:43:27 +0100
Subject: [GIT PULL] Allwinner core additions for 3.15
Message-ID: <20140313164327.GA13229@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

Please pull the following changes for 3.15.

Thanks!

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.15

for you to fetch changes up to 8db21ad469fda194913db2c5b11635bcc21345fc:

  ARM: sunxi: Add the new watchog compatibles to the reboot code (2014-03-13 11:46:20 +0100)

----------------------------------------------------------------
Allwinner core additions for 3.15

Just a minor commit to adjust the restart code to take into account the new
compatibles

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Add the new watchog compatibles to the reboot code

 arch/arm/mach-sunxi/sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/5741f18d/attachment.sig>
