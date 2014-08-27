From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Aug 2014 13:59:57 +0900
Subject: [PATCH 0/3] clocksource: Document Renesas SoC specific bindings
Message-ID: <1409115600-26192-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
the drivers a number of drivers for Renesas hardware. The purpose of this
patch is to update the Renesas clocksource drivers to follow this convention.

I plan to follow up with patches to use these new bindings in the
dtsi files for the affected SoCs.

Simon Horman (3):
  clocksource: sh_cmt: Document SoC specific bindings
  clocksource: sh_mtu2: Document r7s72100 binding
  clocksource: sh_tmu: Document r8a7779 binding

 .../devicetree/bindings/timer/renesas,cmt.txt      | 26 +++++++++++++++++++++-
 .../devicetree/bindings/timer/renesas,mtu2.txt     |  6 +++--
 .../devicetree/bindings/timer/renesas,tmu.txt      |  6 +++--
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.0.1
