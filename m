From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 22 Nov 2016 19:41:30 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20161122194130.4efdd019@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the clk tree got conflicts in:

  arch/arm/boot/dts/r8a7779.dtsi
  arch/arm/boot/dts/r8a7790.dtsi
  arch/arm/boot/dts/r8a7791.dtsi
  arch/arm/boot/dts/r8a7792.dtsi
  arch/arm/boot/dts/r8a7793.dtsi
  arch/arm/boot/dts/r8a7794.dtsi
  arch/arm/mach-shmobile/setup-rcar-gen2.c
  arch/arm64/boot/dts/renesas/r8a7795.dtsi
  arch/arm64/boot/dts/renesas/r8a7796.dtsi
  drivers/soc/renesas/Makefile

between various commits from the arm-soc tree and commits from the
clk tree.

It was just too much at this time of day, so please talk to each other
and figure out how to fix these up.  I have used the clk tree from
next-20161117 for today.

-- 
Cheers,
Stephen Rothwell
