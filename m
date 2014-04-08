From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 9 Apr 2014 02:21:52 +0400
Subject: [PATCH 0/2] Add USB PHY DT support for R8A7791/Koelsch reference board
Message-ID: <201404090221.53167.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140408' tag plus R8A7791/Koelsch PCI USB support patches
that I posted yesterday. Here we add the USB PHY device tree support on the
R8A779/Koelsch reference board. The patchset requires the USB PHY driver (just
re-posted) in order to work.

[1/2] ARM: shmobile: r8a7791: add USB PHY DT support
[2/2] ARM: shmobile: koelsch: enable USB PHY

WBR, Sergei
