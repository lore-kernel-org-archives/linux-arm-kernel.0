From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 12 Jun 2016 13:23:25 +0200
Subject: [GIT PULL] ARM: at91: defconfig for 4.8 #1
Message-ID: <20160612112325.GA25924@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A single patch adding the AT91 platforms to multi_v5 so we can get
kernelci coverage for multi_v5 on AT91.


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-defconfig

for you to fetch changes up to 837f27a2c1b4093cda301aead20fcf7d04acc12a:

  ARM: multi_v5_defconfig: enable Atmel platforms (2016-06-11 00:58:51 +0200)

----------------------------------------------------------------
Defconfig changes for 4.8:
 - Add at91sam9 platforms in multi_v5

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: multi_v5_defconfig: enable Atmel platforms

 arch/arm/configs/multi_v5_defconfig | 54 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/9a2bd1ac/attachment.sig>
