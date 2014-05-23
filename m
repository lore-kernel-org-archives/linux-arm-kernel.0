From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 May 2014 02:34:46 +0400
Subject: [PATCH v2 0/3] Add USB PHY DT support for R8A7791/Koelsch/Henninger
 board
Message-ID: <201405240234.47303.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140521' tag plus R8A7791/Koelsch/Henninger PCI USB
support patches that I posted earlier. Here we add the USB PHY device tree
support on the R8A7791/Koelsch/Henninger boards. The patchset requires the USB
PHY driver (just re-posted) in order to work.

[1/3] ARM: shmobile: r8a7791: add USB PHY DT support
[2/3] ARM: shmobile: koelsch: enable USB PHY
[3/3] ARM: shmobile: henninger: enable USB PHY

WBR, Sergei
