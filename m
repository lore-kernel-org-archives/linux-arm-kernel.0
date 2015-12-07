From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 17:48:22 +0100
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.5 (#1)
Message-ID: <87r3iycii1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for cleanup for mvebu for v4.5.
(This is part of a first PR series of commit already in linux-next
since a few weeks, if everything goes well, I planned a second PR at
the end of the week)

Gregory

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.5-1

for you to fetch changes up to 843cd366555ba7c676aa9ec3e468fa4602a8acba:

  ARM: mvebu: remove unused mach/gpio.h (2015-12-01 13:48:44 +0100)

----------------------------------------------------------------
mvebu cleanup for 4.5 (part 1)

remove unused mach/gpio.h in mach-mvebu

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: mvebu: remove unused mach/gpio.h

 arch/arm/mach-mvebu/include/mach/gpio.h | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
