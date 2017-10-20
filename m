From: mihailescu2m@gmail.com (Marian Mihailescu)
Date: Fri, 20 Oct 2017 22:39:12 +1030
Subject: [PATCH] ARM: dts: exynos: add cpu perf counters to Exynos54xx boards
Message-ID: <CAM3PiRxi8sxf6T990K8rd7UsOLd2D5TaLciF=c_wF=9gmpLKYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch enables support for ARM Performance Monitoring Units
available in Cortex-A7
and Cortex-A15 CPU cores for Exynos54xx SoCs (5410, 5420 and 5422/5800).

Exynos5410 currently has only Cortex-A7 nodes defined in the device tree,
so the Cortex-A15 PMU is defined in the exynos5420 device tree file.

Tested with perf on Odroid XU4 (Exynos5422):
armv7_cortex_a7 PMU driver: 5 counters available
armv7_cortex_a15 PMU driver: 7 counters available

Regards,
Marian

--
Either I've been missing something or nothing has been going on. (K. E. Gordon)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-dts-exynos-add-cpu-perf-counters-to-Exynos54xx-b.patch
Type: application/octet-stream
Size: 2272 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/d5dc1f5c/attachment.obj>
