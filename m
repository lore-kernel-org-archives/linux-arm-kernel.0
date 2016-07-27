From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 27 Jul 2016 23:55:52 +0300
Subject: [PATCH v3 0/6] Add R8A7794/SILK sound DT support
Message-ID: <3910788.ckTpUWEs6B@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 6 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160725-v4.7-rc7' tag. I'm adding the sound device tree support
for the R8A7794 SoC based SILK board.

[1/6] ARM: dts: r8a7794: add audio clocks
[2/6] ARM: dts: r8a7794: add MSTP5 clocks
[3/6] ARM: dts: r8a7794: add MSTP10 clocks
[4/6] ARM: dts: r8a7794: add Audio-DMAC support
[5/6] ARM: dts: r8a7794: add sound support
[6/6] ARM: dts: silk: add sound support

WBR, Sergei
