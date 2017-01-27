From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Fri, 27 Jan 2017 16:39:25 +0000
Subject: [GIT PULL] STi DT update for v4.11 round 2
Message-ID: <f5af2119-21ac-7116-5109-1a8837f87cfb@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this second round of STi dts update for v4.11 :

The following changes since commit 2016ead446b98c42dffd9b6c03ce813e5cb3b810:

   ARM: dts: STiH407-family: Supply Mailbox properties to delta RProc 
(2017-01-12 17:23:39 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
tags/sti-dt-for-v4.11-round2

for you to fetch changes up to bda0f85acb1a2a3b670e983607940d6b73b1fc73:

   ARM: dts: STiH407-family: Add missing pwm irq (2017-01-27 17:28:16 +0100)

----------------------------------------------------------------
STi DT fix:

Add missing interrupt node to properly probe the pwm device.

----------------------------------------------------------------
Lionel Debieve (1):
       ARM: dts: STiH407-family: Add missing pwm irq

  arch/arm/boot/dts/stih407-family.dtsi | 1 +
  1 file changed, 1 insertion(+)
