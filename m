From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 May 2014 02:26:26 +0400
Subject: [PATCH v2 0/2] Add USB PHY device tree support for R8A7790/Lager board
Message-ID: <201405240226.27820.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Oops, have sent this out with stale subject. Resending...

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140521' tag plus R8A7790/Lager PCI USB support patches
that I posted earlier. Here we add the USB PHY device tree support on the
R8A7790/Lager reference board. The patchset requires the USB PHY driver (re-
posted recently) in order to work.

[1/2] ARM: shmobile: r8a7790: add USB PHY DT support
[2/2] ARM: shmobile: lager: enable USB PHY

WBR, Sergei
