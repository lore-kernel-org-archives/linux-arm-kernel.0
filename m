From: anup@brainfault.org (Anup Patel)
Date: Tue, 24 Apr 2012 19:06:34 +0530
Subject: [ANNOUNCE] [OFFTOPIC] Xvisor ARM with and/or without virtualization
 extensions
Message-ID: <CAAhSdy12KufzNtrf6wYY7rK0LZMPC-_-4N+p4JwJsV5MB6HTDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xvisor (eXtensible Versatile hypervISOR) is an open source bare-metal
monolithic hypervisor, which aims towards providing virtualization solution,
which is light-weight, portable, and flexible with small memory foot print
and less overhead. It is distributed under GNU Public License (GPLv2).

Xvisor has most of the features expected from a modern full-fledged hypervisor,
such as:
??? - Tree based configuration
??? - Tickless and high resolution timekeeping
??? - Wall-clock for tracking real-time
??? - Threading framework
??? - Host device driver framework
??? - CPU virtualization
??? - Address space virtualization
??? - IO device emulation framework
??? - Pass through hardware access
??? - Dynamic guest creation/destruction
??? - Serial port virtualization
??? - Management terminal

The ARM port of Xvisor (or Xvisor ARM) supports a wide range of ARM processors
namely:
??? - ARM9 (Boards: VersatilePB)
??? - Cortex-A8 (Boards: Realview-PB-A8)
??? - OMAP3 (Boards: BeagleBoard-xM)
??? - Cortex-A9 (UP) (Boards: Vexpress-A9)
??? - Cortex-A15 (UP) Without VE (Boards: Vexpress-A15)
??? - Cortex-A15 (UP) With VE (Boards: Vexpress-A15)

For all supported ARM processors Xvisor ARM is able to boot multiple unmodified
Linux-3.0.4 guest with a fairly interactive and smooth Busybox 0.19.2 console.

On real hardware specifically BeagleBoard-xM (OMAP3 @ 600 MHz) we get near
native CPU performance (i.e. Native Linux 3.0.4 gives 1120 DMIPS whereas Linux
3.0.4 running as guest on Xvisor ARM gives 960 DMIPS)

Please try out our Xivsor Cortex-A15 demo on ARM Fast Models 7.0 and/or
Linaro QEMU (2.02 or higher). To download the demo tarball visit:
https://docs.google.com/open?id=0B0ABS_s60oP_WjNQQ0QtUzNmdmc

Xvisor is currently hosted on Github, to clone or download source code please
visit following links:
Wiki: https://github.com/xvisor/xvisor/wiki
Mainline Repository: https://github.com/xvisor/xvisor
Stagging Repository: https://github.com/avpatel/xvisor-next

Our developer mailing list is xvisor-devel[at]googlegroups[
dot]com, please feel free to post your queries or join our development
mailing list.
