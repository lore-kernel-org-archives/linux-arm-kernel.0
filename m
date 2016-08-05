From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Aug 2016 21:24:40 +0300
Subject: [PATCH 0/2] Add R8A7792 DU support
Message-ID: <4031442.KeMCTMarLN@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160725-v4.7-rc7' tag. We're adding the R8A7792 DU clocks and
device nodes. They have been tested on the Blanche board -- I'm not posting the
Blanche patch only because it also has some strange interaction with the
Ethernet chip, so that NFS root can't work anymore...

[1/2] ARM: dts: r8a7792: add DU clocks
[2/2] ARM: dts: r8a7792: add DU support

WBR, Sergei
