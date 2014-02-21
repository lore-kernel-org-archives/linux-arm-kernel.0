From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:11:58 +0900
Subject: [GIT PULL] Renesas intc Updates for v3.15
Message-ID: <cover.1392962498.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this Renesas ARM based SoC intc updates for v3.15.

Previously merging code for this driver was handled Paul Mundt
as part of his maintenance of SUPERH. However, SUPERH is in
the process of being orphaned. And as this driver is also listed
as being maintained by Magnus and myself as part of ARM/SHMOBILE ARM
I have picked up this patch.

If you would prefer not to handle this that is quite fine by me but in that
case I would appreciate advice on where I should send pull-requests.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-intc-for-v3.15

for you to fetch changes up to 4f3068f60503e08bc9e729528d9e54289980fa96:

  sh: intc: Enable driver compilation with COMPILE_TEST (2014-02-18 09:22:21 +0900)

----------------------------------------------------------------
Renesas intc Updates for v3.15

* Enable driver compilation with COMPILE_TEST

----------------------------------------------------------------
Laurent Pinchart (1):
      sh: intc: Enable driver compilation with COMPILE_TEST

 drivers/sh/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
