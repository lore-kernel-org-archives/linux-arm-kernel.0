From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 24 Nov 2016 01:05:47 -0600
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.10 - Part 2
Message-ID: <1479971147-15222-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, and Arnd,

Please consider taking this additional set of updates for 4.10.  These
apply on top of the previous tagged set of changes.


The following changes since commit d4714a5ab2132e899a531bcd267bd13555244927:

  Merge tag 'qcom-dts-for-4.10-1' into dts-for-4.10-2 (2016-11-24 00:24:40 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.10-2

for you to fetch changes up to a91b2e690d409476d711523be8a83062b9083fb2:

  ARM: dts: Add xo to sdhc clock node on qcom platforms (2016-11-24 00:31:02 -0600)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.10 - Part 2

* Add SDHC xo clk

----------------------------------------------------------------
Ritesh Harjani (1):
      ARM: dts: Add xo to sdhc clock node on qcom platforms

 arch/arm/boot/dts/qcom-apq8084.dtsi | 16 ++++++++++------
 arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)
