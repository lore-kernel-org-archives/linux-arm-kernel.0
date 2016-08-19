From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 20 Aug 2016 01:17:09 +0300
Subject: [PATCH 0/2] Add R8A7792 VSP1V support
Message-ID: <1635089.v8k0jcJkvb@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160817-v4.8-rc2' tag. We're adding the R8A7792 VSP1V clocks
and device nodes. The 2nd patch depends on the VSP1 driver patch in order for
the VSP1V core to be recognized by the driver. The patches have been tested on
the Blanche board...

[1/2] ARM: dts: r8a7792: add VSP1V clocks
[2/2] ARM: dts: r8a7792: add VSP1V support

WBR, Sergei
