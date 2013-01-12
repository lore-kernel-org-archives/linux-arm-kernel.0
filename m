From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 12 Jan 2013 16:09:49 +1300
Subject: [PATCH 0/4] arm: vt8500: Add support for Wondermedia WM8750/WM8850
In-Reply-To: <1357960163.8515.3.camel@gitbox>
References: <1357935162-7672-1-git-send-email-linux@prisktech.co.nz>
 <20130111215659.GA16521@quad.lixom.net> <1357960044.8515.0.camel@gitbox>
 <1357960163.8515.3.camel@gitbox>
Message-ID: <1357960189.8515.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit
ce3f386fdf10d79eaf6ebd63bb7adbd95f08f9f0:

  arm: vt8500: Remove remaining mach includes (2013-01-12 15:47:39
+1300)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git tags/armsoc-3.9

for you to fetch changes up to 8d31bfa551b9a1a61119e6d8fde08d0fa8cdfafb:

  arm: vt8500: Add support for Wondermedia WM8750/WM8850 (2013-01-12
15:51:24 +1300)

----------------------------------------------------------------
arm: vt8500: Add support for WM8750 and WM8850 SoCs.

This pull should be on top of:
git://server.prisktech.co.nz/git/linuxwmt.git
tags/vt8500-multiplatform-3.9

----------------------------------------------------------------
Tony Prisk (1):
      arm: vt8500: Add support for Wondermedia WM8750/WM8850

 Documentation/devicetree/bindings/arm/vt8500.txt |    8 ++++++++
 arch/arm/mach-vt8500/Kconfig                     |   16
++++++++++++++++
 arch/arm/mach-vt8500/vt8500.c                    |    2 ++
 3 files changed, 26 insertions(+)
