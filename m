From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Jul 2016 00:09:02 +0300
Subject: [PATCH 0/2] Add R8A7792 SDHI support
Message-ID: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160711-v4.7-rc7' tag plus the R8A7792 PFC/GPIO/EtherAVB
patchsets. We're adding the R8A7792 SDHI clocks and device nodes. They have
been tested on the Blanche board -- I'm not posting the Blanche patch only
because it has some strange interaction with the Ethernet chip, so that NFS
root woedn't work anymore...

[1/2] ARM: dts: r8a7792: add SD clocks
[2/2] ARM: dts: r8a7792: add SDHI support

WBR, Sergei
