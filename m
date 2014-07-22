From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Jul 2014 01:13:45 +0400
Subject: [PATCH v3 0/2] Add USB PHY device tree support for R8A7790/Lager board
Message-ID: <201407230113.46444.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.16-rc5-20140722' tag. Here we add the USB PHY device tree
support on the R8A7790/Lager reference board. The patchset requires the USB PHY
driver (just re-posted) in order to work.

[1/2] ARM: shmobile: r8a7790: add USB PHY DT support
[2/2] ARM: shmobile: lager: enable USB PHY

WBR, Sergei
