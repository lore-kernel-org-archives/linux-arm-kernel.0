From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 16:05:48 +0800
Subject: [GIT PULL 2/3] ZTE device tree updates for 4.14
In-Reply-To: <1503043549-13232-1-git-send-email-shawnguo@kernel.org>
References: <1503043549-13232-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1503043549-13232-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt-4.14

for you to fetch changes up to 8cb46bd224a0ecfc759b685d4bb0538d8e7d51a7:

  ARM: dts: zte: remove num-slots from zx296702-ad1 (2017-07-16 09:18:18 +0800)

----------------------------------------------------------------
ZTE device tree updates for 4.14:
 - A clean up patch from Shawn Lin to remove the deprecated dwmmc
   property 'num-slots'.

----------------------------------------------------------------
Shawn Lin (1):
      ARM: dts: zte: remove num-slots from zx296702-ad1

 arch/arm/boot/dts/zx296702-ad1.dts | 2 --
 1 file changed, 2 deletions(-)
