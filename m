From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 21 Jun 2014 00:44:50 +0400
Subject: [PATCH v3 0/3] Add R8A7791/Koelsch/Henninger board PCI DT support
Message-ID: <201406210044.51620.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.16-rc1-20140618' tag. Here we add PCI USB device tree support
for the R8A7791-based Koelsch and Henninger boards. As the 'pci-rcar-gen2'
driver device tree support has been merged for 3.16, this patchset can now be
merged too... 

[1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
[2/3] ARM: shmobile: koelsch: enable internal PCI
[3/3] ARM: shmobile: henninger: enable internal PCI

WBR, Sergei
