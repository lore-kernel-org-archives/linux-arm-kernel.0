From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Jan 2015 15:50:06 +0100
Subject: [GIT PULL] mvebu: defconfig for v3.20
Message-ID: <20150113145006.GB13100@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd

Here is the first pull request for defconfig for mvebu for v3.20.

     Andrew

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.20

for you to fetch changes up to e42dcfbba1f0ab3050a7c550a4119e2945553042:

  ARM: mvebu: enable CPUFREQ_DT in mvebu_v7_defconfig (2014-12-21 07:00:26 -0600)

----------------------------------------------------------------
mvebu defconfig changes for v3.20

- enable CPUFREQ_DT in mvebu_v7_defconfig

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: enable CPUFREQ_DT in mvebu_v7_defconfig

 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
