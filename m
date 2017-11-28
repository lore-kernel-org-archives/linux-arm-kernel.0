From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 28 Nov 2017 23:15:43 +0300
Subject: [PATCH 0/2] Use R8A77970 CPG core clock and SYSC pwoer domain macros
Message-ID: <20171128201543.932798613@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20171128-v4.15-rc1' tag. Now that the R8A77970 CPG core clock
and SYSC power domain #define's have hit Linus' tree, we can replace the bare
numbers (we had to use to avoid a cross tree dependencies) with these #define's,
at last...

[1/2] arm64: dts: renesas: r8a77970: use CPG core clock macros
[2/2] arm64: dts: renesas: r8a77970: use SYSC power domain macros

WBR, Sergei
