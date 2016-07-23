From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 23 Jul 2016 22:15:56 +0300
Subject: [PATCH 0/2] Add R8A7792 I2C support
Message-ID: <17288006.ERHB6654v5@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160722-v4.7-rc7' tag plus the SDHI/I2C patches just posted.
We're adding the R8A7792 VIN clocks and device nodes. The patches have been
tested on the Blanche board with the switches set to the HDMI input mode...

[1/2] ARM: dts: r8a7792: add VIN clocks
[2/2] ARM: dts: r8a7792: add VIN support

WBR, Sergei
