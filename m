From: torbjorn.jansson@mbox200.swipnet.se (Torbjorn Jansson)
Date: Wed, 21 Nov 2018 10:06:08 +0100
Subject: odroid hc2?
Message-ID: <d2fc632f-e0bb-6d0a-35f6-64fcb16c354e@mbox200.swipnet.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

a question for the experts and a small wish/request.
is it possible to get the odroid hc2 up to same level of support in the kernel 
as hc1?
my understanding is that they are basically the same thing but hc1 uses a 2.5 
inch disk and hc2 uses 3.5 inch discs.

there is two parts to this i believe.
i'm using fedora 29 to test this and the first part is that uboot (i think) 
doesn't recognize the hc2 properly so it tries to load the dtb file 
exynos5422-odroidunknown.dtb
i can work around this by creating a symlink from exynos5422-odroidhc1.dtb and 
get it to boot.

second part is ofcourse that there is no dtb file for hc2 so even if uboot did 
pickup the right file it wound not exist.

using the hc1 dtb file with my hc2 appears to work fine.
