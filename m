From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 23 Jun 2018 00:10:36 -0500
Subject: [GIT PULL] Qualcomm Fixes for v4.18-rc1
Message-ID: <1529730636-32672-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.18-rc1

for you to fetch changes up to 6b4154a655a258c67bcfabbd4c3a06637e74ebcd:

  arm64: dts: msm8916: fix Coresight ETF graph connections (2018-06-23 00:00:05 -0500)

----------------------------------------------------------------
Qualcomm Fixes for v4.18-rc1

* Fix coresight graph on msm8916
* Disable uart0 on db820c by default

----------------------------------------------------------------
Rob Herring (1):
      arm64: dts: msm8916: fix Coresight ETF graph connections

Srinivas Kandagatla (1):
      arm64: dts: apq8096-db820c: disable uart0 by default

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
