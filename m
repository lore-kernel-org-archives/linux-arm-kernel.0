From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Oct 2013 19:26:15 +0200
Subject: [GIT PULL] Allwinner sunXi fixes for 3.13
Message-ID: <20131018172615.GA14943@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof,

Please pull this minor fix for the 3.13 merge window.

Thanks,
Maxime

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-fixes-for-3.13

for you to fetch changes up to 439d9f58017af96f0375d9443ff957c19056d6ec:

  ARM: sun6i: Fix the APB2 clock gates register size (2013-10-05 15:36:10 +0200)

----------------------------------------------------------------
Allwinner sunXi SoCs minor fixes for 3.13

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sun6i: Fix the APB2 clock gates register size

 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/ccdbb1a6/attachment.sig>
