From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 18:44:02 +0200
Subject: [PATCH 0/2] ARM: sunxi: Convert DTSI to new CPU bindings
Message-ID: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Sorry for steping in so late, but these two patches fixes a warning
introduced by the commit 1ba9bf0a (ARM: 7762/1: kernel: fix
arm_dt_init_cpu_maps() to skip non-cpu nodes) after 3.10-rc7.

These two patches solve the situation for sunxi. The first one by
Lorenzo is to be applied for 3.10 if it's still possible, and the
second one on top of arm-soc/for-next. Tell me if you prefer a more
formal pull request for these patches

Thanks!
Maxime

Lorenzo Pieralisi (1):
  ARM: dts: sunxi: cpus/cpu nodes dts updates

Maxime Ripard (1):
  sunxi: a10s: dtsi: Convert cpu node to the new cpu bindings

 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 ++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 ++
 3 files changed, 6 insertions(+)

-- 
1.8.3.1
