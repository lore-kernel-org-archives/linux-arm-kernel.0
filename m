From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 21 Jul 2018 10:32:21 +0800
Subject: [GIT PULL 3/6] i.MX DT updates with clock dependency for 4.19
In-Reply-To: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1532140344-2771-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This pull request contains a DT patch that depends on clock changes,
which has been pulled into here as dependency.  Stephen confirmed that
the clock topic branch being merged here is for 4.19 and will be stable.
So please consider to pull the request for 4.19.  Thanks.

Shawn


The following changes since commit 4a2eaa8e2567297d4dc6e2709841a874927c83aa:

  clk: imx6ul: remove clks_init_on array (2018-06-29 11:43:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-clkdep-4.19

for you to fetch changes up to bc36b2aac4f5e4accfe642bb51293f3d318312eb:

  ARM: dts: imx6ul: add GPIO clocks (2018-07-12 08:57:33 +0800)

----------------------------------------------------------------
i.MX device tree changes with clock dependency:
 - Add clock for i.MX6UL GPIO blocks

----------------------------------------------------------------
Anson Huang (1):
      ARM: dts: imx6ul: add GPIO clocks

 arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
 1 file changed, 5 insertions(+)
