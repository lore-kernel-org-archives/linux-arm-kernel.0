From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Dec 2013 02:26:38 +0300
Subject: [PATCH 0/1] Add Ether's PHY IRQ support for R8A7791/Koelsch board
Message-ID: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the patch against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.13-rc4-20131219' tag. Here we add support for the Ether's PHY
IRQ to the R8A7791/Koelsch board. The patchset depends on the two 'sh_eth' driver
patches posted earlier in order to compile and work.

[1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ

WBR, Sergei
