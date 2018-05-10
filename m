From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 10 May 2018 21:07:32 +0300
Subject: [PATCH 0/2] Add V3H Starter Kit board support
Message-ID: <3923fc5f-103c-94c9-57ba-cb29e8c55d05@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180509-v4.17-rc4' tag. I'm adding the device tree support
for the R8A77980-based V3H Starter Kit board; only serial console is supported
for now, NFS support will require more work (it won't use EtherAVB but GEther)
and will be posted later...

[1/2] dt-bindings: arm: document Renesas V3HSK board bindings
[2/2] arm64: dts: renesas: initial V3HSK board device tree

WBR, Sergei
