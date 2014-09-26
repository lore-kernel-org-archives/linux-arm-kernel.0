From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 27 Sep 2014 01:05:41 +0400
Subject: [PATCH v4 0/3] Add USB PHY device tree support for
 R8A7791/Koelsch/Henninger board
Message-ID: <3383603.zZsCVpCDbD@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20140924-v3.17-rc6' tag. Here we add the USB PHY device tree
support on the R8A7791/Koelsch/Henninger boards. The patchset requires the USB
PHY driver already merged by Kishon and Greg in order to work, so can be
applied at last...

[1/3] ARM: shmobile: r8a7791: add USB PHY DT support
[2/3] ARM: shmobile: koelsch: enable USB PHY
[3/3] ARM: shmobile: henninger: enable USB PHY

WBR, Sergei
