From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 11 Jul 2016 09:41:17 +0200
Subject: [GIT PULL v3] STi SoC changes for v4.8
Message-ID: <57834D9D.4070900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi SoC updates for v4.8:

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

   Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
tags/sti-soc-for-v4.8

for you to fetch changes up to 7b8e0188fa717cd9abc4fb52587445b421835c2a:

   ARM: sti: Implement dummy L2 cache's write_sec (2016-07-11 09:15:44 
+0200)

----------------------------------------------------------------
Highlights:
-----------
- Add a dummy L2 cache's write_sec callback as in non secure mode execution,
    we can't get access to L2 cache secure registers
- Cosmetics change, in case of dump_stack, update the hardware name with a
    more generic for the STi SoCs family

----------------------------------------------------------------
Patrice Chotard (1):
       ARM: sti: Implement dummy L2 cache's write_sec

Peter Griffin (1):
       ARM: STi: Update machine _namestr to be more generic.

  arch/arm/mach-sti/board-dt.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)
