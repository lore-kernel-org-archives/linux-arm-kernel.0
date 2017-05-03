From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 4 May 2017 08:33:36 +1000
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20170504083336.35ed36ee@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Sorry that I did not notice this at the time ... This is now in Linus'
tree.

After merging the drm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/configs/multi_v7_defconfig:596:warning: symbol value 'm' invalid for ROCKCHIP_ANALOGIX_DP
arch/arm/configs/multi_v7_defconfig:597:warning: symbol value 'm' invalid for ROCKCHIP_DW_HDMI
arch/arm/configs/multi_v7_defconfig:598:warning: symbol value 'm' invalid for ROCKCHIP_DW_MIPI_DSI
arch/arm/configs/multi_v7_defconfig:599:warning: symbol value 'm' invalid for ROCKCHIP_INNO_HDMI

Introduced by commit

  8820b68bd378 ("drm/rockchip: Refactor the component match logic.")

-- 
Cheers,
Stephen Rothwell
