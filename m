From: chunyan.zhang@unisoc.com (Chunyan Zhang)
Date: Thu, 18 Oct 2018 17:17:33 +0800
Subject: [GIT PULL] sprd dts for kernel v4.20-rc1
Message-ID: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:

https://github.com/lyrazhang/linux.git m-v4.19-rc1

Please let me know if there's some problem.

Thanks,
Chunyan

----------------------------------------------------------------

Suzuki K Poulose (1):
  arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
    ports

 arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
 2 files changed, 151 insertions(+), 142 deletions(-)
