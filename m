From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 7 Feb 2014 00:54:38 +0300
Subject: [PATCH 0/2] Add Ether DT support for R8A7790/Lager reference board
Message-ID: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-rc1-20140206v2' tag. Here we add the Ether device tree
support working on the R8A7790/Lager reference board. The patchset requires the
'sh_eth' driver device tree support posted earlier in order to work.

[1/2] ARM: shmobile: r8a7790: add Ether DT support
[2/2] ARM: shmobile: lager: add Ether DT support

WBR, Sergei
