From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jul 2016 23:18:53 +0300
Subject: [PATCH 0/3] Add R8A7792/Blanche CAN support
Message-ID: <34968644.DhifNderY8@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160711-v4.7-rc7' tag plus the R8A7792 PFC/GPIO/EtherAVB/SDHI
patchsets. We're adding the R8A7792/Blanche CAN clocks and device nodes. The
board patch depends on the PFC driver CAN patch in order for the CAN pins to be
configured...

[1/3] ARM: dts: r8a7792: add CAN clocks
[2/3] ARM: dts: r8a7792: add CAN support
[3/3] ARM: dts: blanche: add CAN0 support

WBR, Sergei
