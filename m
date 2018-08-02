From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 02 Aug 2018 14:42:28 +0200
Subject: [PATCH v3 4/4] arm64: dts: rockchip: add PX30 eavluation board
 devicetree
In-Reply-To: <1533113116-8820-5-git-send-email-cl@rock-chips.com>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
 <1533113116-8820-5-git-send-email-cl@rock-chips.com>
Message-ID: <2650340.eNOEUyGAWg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 1. August 2018, 10:45:16 CEST schrieb cl at rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch add px30-evb.dts for PX30 evaluation board.
> Tested on PX30 evb.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied with the following changes:
- some reordering
- changed chosen from using bootargs to stdout-path
- split out rk809 node into separate patch to be applied once the
  rk809 changes land
- split out dwc2 into separate patch to be applied once the binding lands
- dropped commented cd-gpios from &sdmmc node


Heiko
