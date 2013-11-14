From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Nov 2013 02:17:23 +0300
Subject: [PATCH v2 0/3] Add Ether support for R8A7791/Koelsch board
Message-ID: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Resending with correct subject...

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.12-20131112' tag. Here we add the Ether support to the
R8A7791/Koelsch board. The patchset requires the 'sh_eth' driver R8A7791
support patch posted earlier in order to work.

[1/3] ARM: shmobile: r8a7791: add Ether clock
[2/3] ARM: shmobile: Koelsch: add Ether support
[3/3] ARM: shmobile: Koelsch: enable Ether in defconfig

WBR, Sergei
