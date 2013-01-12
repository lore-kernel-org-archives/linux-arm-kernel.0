From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 12 Jan 2013 16:09:23 +1300
Subject: [PATCH 0/4] arm: vt8500: Add support for Wondermedia WM8750/WM8850
In-Reply-To: <1357960044.8515.0.camel@gitbox>
References: <1357935162-7672-1-git-send-email-linux@prisktech.co.nz>
 <20130111215659.GA16521@quad.lixom.net> <1357960044.8515.0.camel@gitbox>
Message-ID: <1357960163.8515.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit
d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git
tags/vt8500-multiplatform-3.9

for you to fetch changes up to ce3f386fdf10d79eaf6ebd63bb7adbd95f08f9f0:

  arm: vt8500: Remove remaining mach includes (2013-01-12 15:47:39
+1300)

----------------------------------------------------------------
arm: vt8500: Convert arch-vt8500 to multiplatform only.

----------------------------------------------------------------
Tony Prisk (3):
      arm: vt8500: Remove single platform Kconfig options
      arm: vt8500: Convert debug-macro.S to be multiplatform friendly
      arm: vt8500: Remove remaining mach includes

 arch/arm/Kconfig                                   |   16 ---------
 arch/arm/Kconfig.debug                             |    8 +++++
 .../mach/debug-macro.S => include/debug/vt8500.S}  |   24 ++++++++-----
 arch/arm/mach-vt8500/Kconfig                       |   11 ++++--
 arch/arm/mach-vt8500/include/mach/timex.h          |   26
--------------
 arch/arm/mach-vt8500/include/mach/uncompress.h     |   37
--------------------
 6 files changed, 31 insertions(+), 91 deletions(-)
 rename arch/arm/{mach-vt8500/include/mach/debug-macro.S =>
include/debug/vt8500.S} (56%)
 delete mode 100644 arch/arm/mach-vt8500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/uncompress.h
