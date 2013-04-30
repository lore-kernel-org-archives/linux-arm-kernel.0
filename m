From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 May 2013 02:42:36 +0400
Subject: [PATCH v7 0/9] Reorganize R8A7779/Marzen USB code
Message-ID: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130426' tag.  It was created to fix the shortcomings in the
R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
to touch both subtrees). The patches were conceived with the complete
bisectability goal in mind.

[1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
[2/9] ehci-platform: add pre_setup() method to platform data
[3/9] ARM: shmobile: r8a7779: setup EHCI internal buffer
[4/9] rcar-phy: remove EHCI internal buffer setup
[5/9] ARM: shmobile: r8a7779: remove USB PHY 2nd memory resource
[6/9] rcar-phy: correct base address
[7/9] rcar-phy: add platform data
[8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
[9/9] rcar-phy: handle platform data

WBR, Sergei
