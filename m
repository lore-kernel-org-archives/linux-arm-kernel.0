From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 21 Jun 2014 00:34:57 +0400
Subject: [PATCH v4 0/2] Add R8A7790/Lager board PCI USB DT support
Message-ID: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-v3.16-rc1-20140618' tag. Here we add PCI USB device tree support
for the R8A7790-based Lager board. As the 'pci-rcar-gen2' driver device tree
support has been merged for 3.16, this patchset can now be merged too...

[1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
[2/2] ARM: shmobile: lager: enable internal PCI

WBR, Sergei
