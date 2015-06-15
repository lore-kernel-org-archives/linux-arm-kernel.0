From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Jun 2015 02:41:07 +0300
Subject: [PATCH v2 0/2] Add R8A7790 EtherAVB DT support
Message-ID: <2857896.YA1bBSQVkA@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20150610-v4.1-rc7' tag. Here we add the EtherAVB device tree
support for the R8A7790 SoC. The 2nd patch depends on the EtherAVB driver
merged into the 'net-next.git' repo recently for the bindings...

[1/2] ARM: shmobile: r8a7790: add EtherAVB clocks
[2/2] ARM: shmobile: r8a7790: add EtherAVB DT support

WBR, Sergei
