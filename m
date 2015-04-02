From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 02 Apr 2015 10:50:59 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.0
Message-ID: <551D02F3.9020905@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.0.
It comes pretty late because I was waiting for feedback on it and
I forgot it :/

There is only one commit but which fixes a real problem: when CPU idle
is activated on Armada 38x, the system becomes instable on heavy load.

Gregory

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.0

for you to fetch changes up to 548ae94c1cc7fc120848757249b9a542b1080ffb:

  ARM: mvebu: Disable CPU Idle on Armada 38x (2015-03-31 18:47:33 +0200)

----------------------------------------------------------------
mvebu fix for 4.0

Disable CPU Idle on Armada 38x

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Disable CPU Idle on Armada 38x

 arch/arm/mach-mvebu/pmsu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
