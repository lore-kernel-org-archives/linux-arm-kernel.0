From: anup@brainfault.org (Anup Patel)
Date: Fri, 28 Oct 2011 17:35:16 +0530
Subject: [ANNOUNCE] [OFFTOPIC] Xvisor: eXtensible Versatile hypervISOR
Message-ID: <CAAhSdy227WA-+6AGzP1iw1m6Ubs2SUhuz81PMscceWxYuPe5eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Announcing Xvisor v0.1.0, a new open source bare-metal hypervisor, which aims
towards providing virtualization solution, which is light-weight, portable,
and flexible with small memory foot print and less virtualization overhead.
It is distributed under GNU Public License (GPLv2).

Xvisor has most of the features expected from a modern full fledged hypervisor:
 - Tree based configuration
 - Tickless and high resolution timekeeping
 - Threading framework
 - Device driver framework
 - CPU virtualization
 - Address Space virtualization
 - Device emulation framework
 - Serial port virtualization
 - Managment terminal

Xvisor is currently being ported for two architectures: ARM and MIPS. The
development & testing is being done using QEMU (0.14.xx or higher).

Xvisor ARM is able to boot multiple unmodified Linux-2.6.30.10 or Linux-3.0.4
guest with a fairly interactive and smooth Busybox 0.19.2 console. Currently
supported host for Xvisor ARM is Realview-PB-A8 Board emulated by QEMU. It is
also being ported to real hardware, specifically Beagle Board.

Please try out our Xivsor ARM demo on QEMU (0.14.xx or higher). To download
the demo tarball visit the link below:
https://docs.google.com/a/brainfault.org/leaf?id=0B0ABS_s60oP_OGE2MDA0MWYtNDUxOS00YWZkLTllMmMtN2M5MmE1ZGM0NDky&hl=en_GB

Xvisor MIPS is still a work in progress and will be announced very soon.

Xvisor is currently hosted on Github, to clone or download source code please
visit following links:
Mainline: https://github.com/xvisor/xvisor
ARM Development: https://github.com/avpatel/xvisor-arm
MIPS Development: https://github.com/hschauhan/xvisor-mips

Our developer mailing list is xvisor-devel[at]googlegroups[dot]com, please feel
free to post your queries or join our development mailing list.
