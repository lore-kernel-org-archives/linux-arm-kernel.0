From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 24 Jun 2014 21:57:04 +0400
Subject: [PATCH v5 0/2] Add R8A7790/Lager board PCI USB DT support
Message-ID: <201406242157.05973.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-v3.16-rc2-20140623' tag. Here we add PCI USB device tree support
for the R8A7790-based Lager board. As the 'pci-rcar-gen2' driver device tree
support has been merged for 3.16, this patchset can now be merged too...

[1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
[2/2] ARM: shmobile: lager: enable internal PCI

WBR, Sergei
