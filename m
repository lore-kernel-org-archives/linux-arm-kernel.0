From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 28 Dec 2016 13:46:43 +0800
Subject: [PATCH 0/3] Add clock and power domain DT nodes for Mediatek MT2701 
Message-ID: <1482904006-44232-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series base on v4.10-rc1, include MT2701 power domain and clock
DT nodes.

An early patch [1] which was not applied in v4.10-rc1 also included in this
patch series.

[1] https://patchwork.kernel.org/patch/9457625/

James Liao (3):
  arm: dts: mt2701: Sort DT nodes by register address
  arm: dts: mt2701: Add subsystem clock controller device nodes
  arm: dts: mt2701: Add power domain controller device node

 arch/arm/boot/dts/mt2701.dtsi | 84 +++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 18 deletions(-)

--
1.9.1
