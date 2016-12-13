From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 13 Dec 2016 23:22:46 +0800
Subject: [PATCH 0/6] Allwinner A33 CPU frequency scaling support
Message-ID: <20161213152252.53749-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patch adds frequency scaling support to Allwinner A33 SoC.

The first two patches fixes some bugs in the A33 CCU code.

The patch 3 and 4 is for enabling the cpufreq-dt driver to work.

The patch 5 is for enabling the voltage adjusting on reference design tablets.

The patch 6 is for enabling the "turbo-mode" of A33. (According to the
"extremity_freq" property in the FEX file. When I tested it with 3.4 BSP, it
really performs as a turbo mode.)

If there's any doubt of safety, the patch 6 can be ignored.

If there's any problem in patch 3, 4 and 5, they can also be temporarily
ignored, but finally we need them ;-)

Although there's now currently no thermal support for A33, many A33 devices
are tablets with battery, and it will be valuable to save some power energy,
so cpufreq support is also useful.

P.S.

Chen-Yu,

Do you want to test the CCU fix and the operating point table on A23?

Regards,
Icenowy
