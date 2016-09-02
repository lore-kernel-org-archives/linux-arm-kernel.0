From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 03 Sep 2016 01:04:37 +0300
Subject: [PATCH 0/3] Add R8A7792/Wheat QSPI support
Message-ID: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160902-v4.8-rc4' tag plus the Wheat board patches posted this
week. We're adding the R8A7792/Wheat QSPI clocks and device nodes. The board
patch depends on the PFC driver QSPI patch in order for the QSPI pins to be
configured...

[1/3] ARM: dts: r8a7792: add QSPI clock
[2/3] ARM: dts: r8a7792: add QSPI support
[3/3] ARM: dts: wheat: add QSPI support

WBR, Sergei
