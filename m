From: sophian.yoma@gmail.com (yoma sophian)
Date: Sat, 18 Aug 2018 18:01:31 +0800
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
Message-ID: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
in ARM DDI 0487C.a, it seems TBR0_EL1/VBAR_EL1 are not banked in aarch64.
(The paragraph, Accessibility,  in section G7.2.160 (TTBR0,
Translation Table Base Register 0)
 and section G7.2.162 (VBAR, Vector Base Address Register.)

if so, will it not make any secure issue?
suppose EL1_NS change TTBR0 to let EL1_S access wrong page table?
thanks for your kind help in advance,
