From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 16 Aug 2017 10:17:03 -0500
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.14
Message-ID: <1502896623-6905-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.14

for you to fetch changes up to 0d363594c5287390310fa91be28d0efccb334779:

  ARM: dts: qcom: add and enable both wifi blocks on the IPQ4019 (2017-08-08 14:53:12 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.14

* Fixup XO, timer nodes, and pinctrl on IPQ4019
* Add IPQ4019 RNG and wifi blocks
* Update MSM8974 coresight node
* Add IPQ8074 bindings

----------------------------------------------------------------
Christian Lamparter (2):
      ARM: dts: qcom: add pseudo random number generator on the IPQ4019
      ARM: dts: qcom: add and enable both wifi blocks on the IPQ4019

Suzuki K. Poulose (1):
      ARM: dts: qcom-msm8974: dts: Update coresight replicator

Varadarajan Narayanan (3):
      dt-bindings: qcom: Add IPQ8074 bindings
      ARM: dts: ipq4019: Fix pinctrl node name
      ARM: dts: ipq4019: Move xo and timer nodes to SoC dtsi

 Documentation/devicetree/bindings/arm/qcom.txt |   2 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi  |  29 +++----
 arch/arm/boot/dts/qcom-ipq4019.dtsi            | 109 ++++++++++++++++++++++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi            |   2 +-
 4 files changed, 122 insertions(+), 20 deletions(-)
