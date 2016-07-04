From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 05 Jul 2016 00:21:31 +0300
Subject: [PATCH 0/2] Add R8A7792 EtherAVB support
Message-ID: <3308853.O8HBuWdbK9@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160704-v4.7-rc6' tag plus the R8A7792 PFC/GPIO patchsets.
We're adding the R8A7792 EtherAVB clocks and device nodes. They have been
tested on the Blanche board (along with the EtherAVB patches)...

[1/2] ARM: dts: r8a7792: add EtherAVB clocks
[2/2] ARM: dts: r8a7792: add EtherAVB support

WBR, Sergei
