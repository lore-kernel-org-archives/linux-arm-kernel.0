From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 4 Mar 2015 16:20:08 +0100
Subject: [PATCH v3 00/20] ARM: mvebu: Armada 39x basic support, and
 preparatory cleanups
In-Reply-To: <54F71F45.3060503@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <54F71F45.3060503@free-electrons.com>
Message-ID: <20150304162008.1d337e6e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Wed, 04 Mar 2015 16:05:41 +0100, Gregory CLEMENT wrote:

> Patches 1 applied to mvebu/cleanup
> Patches 2 to 8 and patch 17 applied to mvebu/dt
> Patches 9,12,16 and 18 applied to mvebu/soc
> Patch 19 applied to mvebu/defconfig
> 
> and
> 
> Patches 10,13 and 14 applied to mvebu/clk as requested by Mike.
> 
> I had to amend the patch "ARM: mvebu: fix unit address of MPIC nodes"
> by removing the armada-38x related part which was already applied by the
> patch "ARM: mvebu: Fix MPIC unit address".
> 
> Patch 20 should be directly taken by the arm-soc maintainer.

Thanks!

So this leaves only:

  [PATCH v3 11/20] devicetree: bindings: add Device Tree bindings for Armada 39x pin-muxing controller
  [PATCH v3 15/20] pinctrl: mvebu: add pinctrl driver for Marvell Armada 39x

to be applied, right? Patch 15/20 has been applied by Linus Walleij
already, but from the v1 of the series. I also asked him to merge PATCH
v3 11/20.

With this done, and PATCH v2 20/20 merged by the arm-soc maintainers, I
guess we should be all set with this patch series.

Thanks again!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
