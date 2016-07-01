From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 1 Jul 2016 16:31:58 +0200
Subject: STi SoC changes for v4.8
Message-ID: <57767EDE.8050708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi SoC updates for v4.8:

The following changes since commit 4c2e07c6a29e0129e975727b9f57eede813eea85:

   Linux 4.7-rc5 (2016-06-26 17:52:03 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
sti-soc_for_v4.8

for you to fetch changes up to 55aa35180c57d82f3db23e5aabce97acb0d36681:

   ARM: sti: Implement dummy L2 cache's write_sec (2016-07-01 16:23:44 
+0200)
----------------------------------------------------------------

Highlights:
-----------
_ add a dummy L2 cache's write_sec callback as in non secure mode execution,
   we can't get access to L2 cache secure registers
_ cosmetics change, in case of dump_stack, update the hardware name with a
   more genericfor the STi SoCs family


----------------------------------------------------------------
Patrice Chotard (1):
       ARM: sti: Implement dummy L2 cache's write_sec

Peter Griffin (1):
       ARM: STi: Update machine _namestr to be more generic.

  arch/arm/mach-sti/board-dt.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)
