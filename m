From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Oct 2014 00:19:03 +0400
Subject: [PATCH v3 0/2] Add HS-USB device tree support for R8A7790/Lager board
Message-ID: <2438577.UAUDMkTTWI@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141007-v3.17' tag. Here we add the HS-USB device tree support
on the R8A7790/Lager reference board. The patchset requires the USB PHY
driver (already merged by Kishon and Greg) and the generic PHY support patches
for the HS-USB driver posted by Yoshihiro Shimoda in order to work...

[1/2] ARM: shmobile: r8a7790: add HS-USB device node
[2/2] ARM: shmobile: lager: enable HS-USB

WBR, Sergei
