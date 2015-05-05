From: ydroneaud@opteya.com (Yann Droneaud)
Date: Tue, 05 May 2015 12:05:15 +0200
Subject: Device Tree Blob (DTB) licence
Message-ID: <1430820315.19516.26.camel@opteya.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I believe Device Tree Blob (.dtb file) built from kernel's Device Tree 
Sources (.dts, which #include .dtsi, which #include .h) using Device 
Tree Compiler (dtc) are covered by GNU General Public Licence v2 
(GPLv2), but cannot find any reference.

As most .dtsi in arch/arm/boot/dts/ are covered by GPLv2, and,
as most .h in include/dt-bindings/ are also covered by GPLv2,
the source code is likely covered by GPLv2.

Then this source code is translated in a different language (flattened 
device tree), so the resulting translation is also likely covered by 
GPLv2.

So, when I'm proposed to download a .dtb file from a random vendor,
can I require to get the associated source code ?

Anyway, for a .dtb file generated from kernel sources, it's rather 
painful to look after all .dts, .dtsi, .h, to find what kind of 
licences are applicables, as some are covered by BSD, dual licensed 
(any combination of X11, MIT, BSD, GPLv2).

Regards.

-- 
Yann Droneaud
OPTEYA
