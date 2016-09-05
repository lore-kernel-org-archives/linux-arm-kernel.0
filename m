From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 05 Sep 2016 23:54:02 +0300
Subject: [PATCH 0/2] Add R8A7792 MSIOF support
Message-ID: <2481458.x1iQg26kO7@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160905-v4.8-rc5' tag. We're adding the R8A7792 MSIOF clocks
and device nodes. I'm not posting the board patches because the MSIOF driver
seems erratic ATM...

[1/2] ARM: dts: r8a7792: add MSIOF clock
[2/2] ARM: dts: r8a7792: add MSIOF support

WBR, Sergei
