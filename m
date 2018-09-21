From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 21 Sep 2018 16:04:35 +0100
Subject: [GIT PULL] arm: dts: hisilicon dts updates for v4.20
Message-ID: <5BA50883.4040708@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please consider to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-arm32-dt-for-4.20

for you to fetch changes up to 6523a0e155c8eeafcb290596aad86388e7577316:

  arm: dts: hip04: Update coresight bindings for hardware ports (2018-09-19 16:28:51 +0100)

----------------------------------------------------------------
ARM: DT: Hisilicon ARM32 SoCs updates for 4.20

- Switch to updated coresight bindings for hip04 SoC

----------------------------------------------------------------
Suzuki K Poulose (1):
      arm: dts: hip04: Update coresight bindings for hardware ports

 arch/arm/boot/dts/hip04.dtsi | 346 ++++++++++++++++++++++---------------------
 1 file changed, 176 insertions(+), 170 deletions(-)
