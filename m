From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 16:31:18 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.11 (round 1)
Message-ID: <20130513203118.GF31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.11-1

for you to fetch changes up to 53e9cb1dcde882cc667497328eca776a9835f965:

  ARM: dove: add si5351 clock driver to CuBox DT (2013-05-13 20:14:56 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.11 (round 1)

 - dove
    - CuBox clock driver

----------------------------------------------------------------
Sebastian Hesselbarth (1):
      ARM: dove: add si5351 clock driver to CuBox DT

 arch/arm/boot/dts/dove-cubox.dts | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)
