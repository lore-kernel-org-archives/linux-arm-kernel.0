From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Apr 2018 13:40:53 +0300
Subject: [PATCH 0/2] Use R8A77980 CPG core clock and SYSC power domain macros
Message-ID: <ea6d3e8a-71a9-9998-f364-7dc82b97c2c0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180425-v4.17-rc2' tag. Now that the R8A77980 CPG core clock
and SYSC power domain #define's have hit Linus' tree, we can replace the bare
numbers (we had to use to avoid a cross tree dependencies) with these #define's,
at last...

[1/2] arm64: dts: renesas: r8a77980: use CPG core clock macros
[2/2] arm64: dts: renesas: r8a77978: use SYSC power domain macros

WBR, Sergei
