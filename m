From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 8 Apr 2014 02:48:13 +0400
Subject: [PATCH 0/2] Add PCI USB DT support for R8A7791/Koelsch reference board
Message-ID: <201404080248.14139.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140403' tag and R8A7791 EHCI clock device tree support
patch. Here we add the PCI USB device tree support on the R8A7791/Koelsch
reference board. The patchset requires the 'pci-rcar-gen2' driver device tree
support (just re-posted) in order to work.

[1/2] ARM: shmobile: r8a7791: add internal PCI bridge nodes
[2/2] ARM: shmobile: koelsch: enable internal PCI

WBR, Sergei
