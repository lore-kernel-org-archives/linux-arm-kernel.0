From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Apr 2015 16:38:14 +0200
Subject: [GIT PULL] Allwinner core changes for 4.1
Message-ID: <20150409143814.GA18254@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This pull request should be the last one for 4.1 (fixes excluded, of
course).

It contains a single patch adding the SMP ops for the Allwinner A23.

Thanks,
Maxime

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.1

for you to fetch changes up to 5aca17ecd0c3e58318a1a6dc317d27419eb1a180:

  ARM: sun8i: Add SMP support for the Allwinner A23 (2015-03-30 15:12:15 -0700)

----------------------------------------------------------------
Allwinner core additions for 4.1

This pull request contains only the changes needed to support the SMP on the
Allwinner A23.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: sun8i: Add SMP support for the Allwinner A23

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/mach-sunxi/platsmp.c                  | 69 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/a2a12bc6/attachment.sig>
