From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Oct 2013 02:16:28 +0300
Subject: [PATCH 0/2] Add Ether support for R8A7791/Koelsch board
Message-ID: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.12-rc7-20131030' tag. Here we add the Ether support to the
R8A7791/Koelsch board. The patchset requires the R8A7791 PFC support posted
earlier in order to work.

[1/2] ARM: shmobile: r8a7791: add Ether clock
[2/2] ARM: shmobile: Koelsch: add Ether support

WBR, Sergei
