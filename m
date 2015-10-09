From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Oct 2015 20:48:14 +0200
Subject: [GIT PULL 3/3] ARM: berlin: SoC changes for v4.4 (round 1)
In-Reply-To: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1444416494-3117-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Marvell Berlin SoC changes for v4.4. It only contains a
single patch to register a cpufreq-dt device that we have properties
for now.

Please pull.

Sebastian

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-soc-for-4.4-1

for you to fetch changes up to e1a3e724a25761a2b2e9e0e059e33afac6409a76:

  ARM: berlin: register cpufreq-dt (2015-09-21 22:57:24 +0200)

----------------------------------------------------------------
Marvell SoC for 4.4 take 1
- register cpufreq-dt device

----------------------------------------------------------------
Antoine Tenart (1):
      ARM: berlin: register cpufreq-dt

 arch/arm/mach-berlin/berlin.c | 6 ++++++
 1 file changed, 6 insertions(+)
