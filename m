From: sergei.shtylyov@cogentembedded.com (sergei.shtylyov at cogentembedded.com)
Date: Wed, 13 Aug 2014 00:10:19 +0400
Subject: [PATCH v5 0/2] Add VIN and ADV7180 device tree support for
 R8A7790/Lager board
Message-ID: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.16-20140811' tag. Here Ben Dooks adds the VIN and ADV7180
video decoder device tree support on the R8A7790/Lager board. The patchset
requires Ben Dooks' 'rcar_vin' and 'soc_camera' DT support patches (already
merged to the 'media_tree.git' repo) in order to work.

[1/2] ARM: shmobile: r8a7790: add VIN device nodes
[2/2] ARM: shmobile: lager: add VIN1/ADV7180 device nodes

WBR, Sergei
