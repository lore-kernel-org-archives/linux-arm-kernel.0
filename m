From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 18:41:04 +0100
Subject: [GIT PULL] Allwinner core changes for 3.20
Message-ID: <20150125174104.GA27274@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes to mach-sunxi for the 3.20 merge window.

Thanks!
Maxime

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-3.20

for you to fetch changes up to f91b7c62e0cdb8a1a72b61b16fcd48858a7d9193:

  ARM: sunxi: Register cpufreq-dt for sun[45678]i (2015-01-07 11:23:05 +0100)

----------------------------------------------------------------
Allwinner core changes for 3.20

  - Support for the A31s
  - Adding support for cpufreq using cpufreq-dt

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: sunxi: Register cpufreq-dt for sun[45678]i

Hans de Goede (1):
      ARM: sunxi: Add "allwinner,sun6i-a31s" to mach-sunxi

 Documentation/arm/sunxi/README |  1 -
 arch/arm/mach-sunxi/platsmp.c  |  2 +-
 arch/arm/mach-sunxi/sunxi.c    | 11 +++++++++++
 drivers/clk/sunxi/clk-sunxi.c  |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/6593cd09/attachment-0001.sig>
